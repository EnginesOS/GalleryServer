class PublishedSoftwaresController < ApplicationController

  before_action :authenticate_admin!, only: [:create, :edit, :update, :destroy]

  def new
    @published_software = PublishedSoftware.new
  end

  def create
    @published_software = PublishedSoftware.new(published_software_params)
    if @published_software.valid?
      if @published_software.load_repository_data
        if @published_software.save
          redirect_to @published_software, notice: 'Software successfully published to gallery.'
        else
          redirect_to @published_software, alert: 'Unable to publish software.'
        end
      else
        redirect_to @published_software, alert: "Unable to load software blueprint from #{@published_software.repository_url}."
      end
    else
      render :new
    end
  end

  def show
    @published_software = PublishedSoftware.find(params[:id])
    respond_to do |format|
      format.json { render json: @published_software }
      format.html {}
    end
    @comments = @published_software.root_comments
    if current_user
      @comment = Comment.build_from( @published_software, current_user.id, nil )
    end
  end

  def index

p params


      if params[:search]
        @published_softwares = PublishedSoftware.where('title LIKE ?', "%#{params[:search]}%")
      else
        @published_softwares = PublishedSoftware.all
      end

    if params[:expose].to_s == 'unpublished' || current_admin
      @published_softwares = @published_softwares
    elsif params[:expose].to_s ==  'unpublished_only'
      @published_softwares = @published_softwares.scope_unpublished
    else
      @published_softwares = @published_softwares.scope_published
    end
    params[:tags] = ( (params[:commit] == 'All' || params[:tags].blank?) ? 'All' : params[:tags] )
    if params[:tags] != 'All'
      @published_softwares = @published_softwares.tagged_with(params[:tags])
    end
    @published_softwares = @published_softwares.page(params[:page]).per( params[:per_page] || 8)
    @published_softwares_json = {
      softwares: @published_softwares.
                    map{|software| software.library_software_record}.
                    map{|software| software[:icon_url] = prepend_url_scheme_host_port_to software[:icon_url]; software},
      page: params[:page],
      total_pages: @published_softwares.total_pages
    }
    respond_to do |format|
      format.json { render json: @published_softwares_json }
      format.html {}
    end
  end

  def edit
    @published_software = PublishedSoftware.find(params[:id])
  end

  def edit_icon
    @published_software = PublishedSoftware.find(params[:id])
  end

  def update
    # render text: params
    @published_software = PublishedSoftware.find(params[:id])
    if @published_software.update(published_software_params)
      redirect_to @published_software, notice: "Successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @published_software = PublishedSoftware.find(params[:id])
    software_title = @published_software.title
    @published_software.destroy
    redirect_to published_softwares_path, notice: "Successfully destroyed #{software_title}."
  end

  def refresh_blueprint_info
    @published_software = PublishedSoftware.find(params[:id])
    @published_software.load_repository_data
    @published_software.save
    redirect_to published_software_path(params[:id]), notice: 'Blueprint information has been refreshed.'
  end

  def refresh_icon_from_blueprint
    @published_software = PublishedSoftware.find(params[:id])
    if @published_software.icon_url_from_blueprint.blank?
      redirect_to published_software_path(params[:id]), alert: 'Icon was not reloaded. The blueprint does not hold an icon.'
    else
      @published_software.update_icon_from_url_in_respository
      if @published_software.save
        redirect_to published_software_path(params[:id]), notice: 'Icon has been reloaded from blueprint.'
      else
        redirect_to published_software_path(params[:id]), alert: 'Icon was not reloaded from blueprint.'
      end
    end
  end

  def add_tag
    @published_software = PublishedSoftware.find(params[:id])
    @published_software.tag_list.add(params[:new_tag].present? ? params[:new_tag] : params[:existing_tag])
    @published_software.save
    redirect_to published_software_path(@published_software, search: params[:search], page: params[:page], tags: params[:tags])
  end

  def remove_tag
    @published_software = PublishedSoftware.find(params[:id])
    @published_software.tag_list.remove(params[:remove_tag])
    @published_software.save
    redirect_to published_software_path(@published_software, search: params[:search], page: params[:page], tags: params[:tags])
  end

private

  def  published_software_params
    result = params.require(:published_software).permit! #(:title, :detail, :repository_url, videos_attributes: [:id])
    result
  end

  def prepend_url_scheme_host_port_to(icon_path)
    request.scheme + '://' + request.host_with_port + icon_path if icon_path.present?
  end

end

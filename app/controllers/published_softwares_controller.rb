class PublishedSoftwaresController < ApplicationController

  before_action :authenticate_admin!, only: [:create, :edit, :update, :destroy]

  def new
    @published_software = PublishedSoftware.new
  end

  def create
    @published_software = PublishedSoftware.new(published_software_params)
    if @published_software.valid?
      if @published_software.load_repository_data
        # @published_software.update_icon_from_url_in_respository
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
      format.json { render json: @published_software, host_with_port: request.host_with_port }
      format.html {}
    end
    @comments = @published_software.root_comments
    if current_user
      @comment = Comment.build_from( @published_software, current_user.id, nil )
    end
  end

  def index
   @published_softwares = PublishedSoftware.search(params[:search])
    respond_to do |format|
      format.json { render json: @published_softwares, host_with_port: request.host_with_port }
      format.html { render :index }
    end
  end

  def edit
    @published_software = PublishedSoftware.find(params[:id])
  end

  def edit_icon
    @published_software = PublishedSoftware.find(params[:id])
  end

  def update
    # if published_software_params[:title].blank?
    #   return redirect_to edit_published_software_path(published_software_params), alert: 'Title cannot be blank.'
    # end
    # if published_software_params[:repository_url].blank?
    #   return redirect_to edit_published_software_path(published_software_params), alert: 'Repository URL must be a valid URL.'
    # end

    @published_software = PublishedSoftware.find(params[:id])
    # render text: published_software_params
    if @published_software.update(published_software_params)
      redirect_to @published_software, notice: "Successfully updated."
    else
      redirect_to edit_published_software_path(published_software_params)
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

private

  def  published_software_params
    result = params.require(:published_software).permit! #(:title, :detail, :repository_url, videos_attributes: [:id])


    # result[:screenshots_attributes]["0"]["_destroy"] = "1"  
    # result[:screenshots_attributes].permit!
    result
  end

end

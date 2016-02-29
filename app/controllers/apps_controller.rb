class AppsController < ApplicationController

  before_action :authenticate_admin!, only: [:create, :edit, :update, :destroy]

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)
    if @app.valid?
      if @app.load_repository_data
        if @app.load_icon_and_save
          redirect_to @app, notice: 'Software successfully published to gallery.'
        else
          redirect_to @app, alert: 'Unable to publish software.'
        end
      else
        redirect_to @app, alert: "Unable to load software blueprint from #{@app.repository_url}."
      end
    else
      render :new
    end
  end

  def show
    @app = App.find(params[:id])
    respond_to do |format|
      format.json { render json: @app }
      format.html {}
    end
    @comments = @app.root_comments
    if current_user
      @comment = Comment.build_from( @app, current_user.id, nil )
    end
  end

  def index
    @apps = App.search(params[:search])
    params[:tags] = ( (params[:commit] == 'All' || params[:tags].blank?) ? 'All' : params[:tags] )
    if params[:tags] != 'All'
      @apps = @apps.tagged_with(params[:tags])
    end
    @apps = @apps.page(params[:page]).per( params[:per_page] || 8)
    @apps_json = {
      softwares: @apps.
                    map{|software| software.library_software_record}.
                    map{|software| software[:icon_url] = prepend_url_scheme_host_port_to software[:icon_url]; software},
      page: params[:page],
      total_pages: @apps.total_pages
    }
    respond_to do |format|
      format.json { render json: @apps_json }
      format.html {}
    end

  end

  def edit
    @app = App.find(params[:id])
  end

  def edit_icon
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
    if @app.update(app_params)
      redirect_to @app, notice: "Successfully updated."
    else
      redirect_to edit_app_path(app_params)
    end
  end

  def destroy
    @app = App.find(params[:id])
    software_title = @app.title
    @app.destroy
    redirect_to apps_path, notice: "Successfully destroyed #{software_title}."
  end

  def refresh_blueprint_info
    @app = App.find(params[:id])
    @app.load_repository_data
    @app.save
    redirect_to app_path(params[:id]), notice: 'Blueprint information has been refreshed.'
  end

  def refresh_icon_from_blueprint
    @app = App.find(params[:id])
    if @app.icon_url_from_blueprint.blank?
      redirect_to app_path(params[:id]), alert: 'Icon was not reloaded. The blueprint does not hold an icon.'
    else
      @app.update_icon_from_url_in_respository
      if @app.save
        redirect_to app_path(params[:id]), notice: 'Icon has been reloaded from blueprint.'
      else
        redirect_to app_path(params[:id]), alert: 'Icon was not reloaded from blueprint.'
      end
    end
  end

  def add_tag
    @app = App.find(params[:id])
    @app.tag_list.add(params[:new_tag].present? ? params[:new_tag] : params[:existing_tag])
    @app.save
    redirect_to app_path(@app, search: params[:search], page: params[:page], tags: params[:tags])
  end

  def remove_tag
    @app = App.find(params[:id])
    @app.tag_list.remove(params[:remove_tag])
    @app.save
    redirect_to app_path(@app, search: params[:search], page: params[:page], tags: params[:tags])
  end

private

  def  app_params
    result = params.require(:app).permit! #(:title, :detail, :repository_url, videos_attributes: [:id])


    # result[:screenshots_attributes]["0"]["_destroy"] = "1"
    # result[:screenshots_attributes].permit!
    result
  end

  def prepend_url_scheme_host_port_to(icon_path)
    request.scheme + '://' + request.host_with_port + icon_path if icon_path.present?
  end

end

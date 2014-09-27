class PublishedSoftwaresController < ApplicationController
 
    
  def new
           @published_software = PublishedSoftware.new
          end
  
          def create
           @published_software = PublishedSoftware.new(published_software_params)
  
                  if @published_software.save
                          redirect_to @published_software
                  else
                          render 'new'
                  end
  
          end

          def show
            @published_software = PublishedSoftware.find(params[:id])
            respond_to do |format|
                 format.json { render json: @published_software }
                 format.html {}
               end
          end
  
          def index
            @published_softwares = PublishedSoftware.all
            respond_to do |format|
                  format.json { render json: @published_softwares }
                  format.html {}
            end
          end
  
          def edit
           @published_software = PublishedSoftware.find(params[:id])
          end
  
           def detailslist
             @published_softwares = PublishedSoftware.all
             respond_to do |format|
                    format.json { render json: @published_softwares }
                     format.html {}
              end
             
           end
  
          def update
           @published_software = PublishedSoftware.find(params[:id])
  
                  if @published_software.update(published_software_params)
                          redirect_to @published_software
                  else
                          render 'edit'
                  end
          end
  
          def destroy
            @published_software = PublishedSoftware.find(params[:id])
            @published_software.destroy
  
            redirect_to published_softwares_path
          end
          
  
  
private
    def  published_software_params
         params.require(:published_software).permit(:short_name ,:full_name, :image_url, :home_page,:repository, :description)
    end
end

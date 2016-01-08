class SoftwareBlueprintController < ApplicationController

  def show
    @published_software = PublishedSoftware.find(params[:software_id])
    render partial: "show"
  end

end

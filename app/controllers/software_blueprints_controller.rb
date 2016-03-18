class SoftwareBlueprintsController < ApplicationController

  def show
    @published_software = PublishedSoftware.find(params[:id])
    render partial: "show"
  end

end

class HomesController < ApplicationController

  def show
    @published_softwares = PublishedSoftware.all.select{|software| software.featured_software}.shuffle.first(3)
  end

end

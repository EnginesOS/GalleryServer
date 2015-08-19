class HomesController < ApplicationController

  def show
    @published_softwares = PublishedSoftware.all.shuffle.first(3)
  end

end

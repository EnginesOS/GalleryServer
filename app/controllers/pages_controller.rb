class PagesController < ApplicationController

  def home
    @published_softwares = PublishedSoftware.all.shuffle.first(3)
  end

  def overview
    # render text: params
  end

end
 
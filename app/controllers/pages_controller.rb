class PagesController < ApplicationController

  def home
    @published_softwares = PublishedSoftware.all.limit(3)
  end

  def overview
    # render text: params
  end

end
 
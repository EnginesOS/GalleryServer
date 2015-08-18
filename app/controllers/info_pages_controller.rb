class InfoPagesController < ApplicationController

  def home
    @published_softwares = PublishedSoftware.all.shuffle.first(3)
  end

  def social_buttons
    render partial: 'social_share_buttons'
  end

  def overview
    # render text: params
  end


end
 
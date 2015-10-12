class InfoPagesController < ApplicationController

  def social_buttons
    render partial: 'social_share_buttons'
  end

  def install_curl_script
    render layout: false, format: :text
  end

end
 
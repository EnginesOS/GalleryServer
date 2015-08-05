class TagsController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def tag_cloud
    @tags = PublishedSoftware.tag_counts_on(:tags)
    render partial: 'tag_cloud'
  end

end

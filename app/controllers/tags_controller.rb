class TagsController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def tag_cloud
    @tags = PublishedSoftware.tag_counts_on(:tags).sort_by { |tag| tag.name.downcase }
    render partial: 'tag_cloud'
  end

  def list_tags_by_name
    render json: PublishedSoftware.list_all_tags_by_name
  end

end

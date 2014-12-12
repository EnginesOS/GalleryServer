class TagsController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

end

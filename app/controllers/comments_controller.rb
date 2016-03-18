class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    # set_parent_object
    if @comment.body.empty?
      redirect_to @comment.commentable, alert: 'Review empty.'
    elsif @comment.save
      redirect_to @comment.commentable, notice: 'Review successfully created.'
    else
      redirect_to @comment.commentable, alert: 'Could not save review.'
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    render text: :hi
    # @comment = Comment.find(params[:id])

    # if @comment.update(comment_params)
    #   redirect_to @comment
    # else
    #   render 'edit'
    # end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end

private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type).tap do |comment_params|
      comment_params[:user_id] = current_user.id
    end
  end

  # def set_parent_object
  #   instance_variable_set(
  #     "@#{comment_params['commentable_type'].underscore}",
  #     comment_params['commentable_type'].constantize.find(comment_params['commentable_id'])
  #     )
  #   set_comments_for_parent
  # end
  #
  # def set_comments_for_parent
  #   instance_variable_set(
  #     "@comments",
  #     instance_variable_get("@#{comment_params['commentable_type'].underscore}").root_comments
  #     )
  # end

end

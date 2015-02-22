class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    instance_variable_set(
      "@#{comment_params['commentable_type'].underscore}",
      comment_params['commentable_type'].constantize.find(comment_params['commentable_id'])
      )
    instance_variable_set(
      "@comments",
      instance_variable_get("@#{comment_params['commentable_type'].underscore}").root_comments
      )
    # render text: @comment.errors.full_messages
    if @comment.save
      @comment = Comment.build_from( instance_variable_get("@#{comment_params['commentable_type'].underscore}"), current_user.id, nil )
    end
    render "#{comment_params['commentable_type'].underscore.pluralize}/show"
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
    params.require(:comment).permit!
  end

end
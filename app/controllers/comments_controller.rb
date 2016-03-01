class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user
    @comment.save

    redirect_to [@project, @commentable], notice: "Comment created..."
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end

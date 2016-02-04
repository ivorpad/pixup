class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @asset = Asset.friendly.find(params[:asset_id])
    @comment = current_user.comments.create(comment_params)
    @new_comment = Comment.new
    @comment.asset_id = @asset.id

      if @comment.save
        flash[:notice] = 'Comment created.'
      else
        flash[:error] = 'Comment cannot be created'
      end

      respond_to do |format|
        format.html
        format.js {}
      end

    end
  def destroy
    @project = Project.friendly.find(params[:project_id])
    @asset = Asset.friendly.find(params[:asset_id])
    @comment = @asset.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = 'Comment removed.'
    else
      flash[:error] = 'Comment cannot be removed'
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

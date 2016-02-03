class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @asset = Asset.friendly.find(params[:asset_id])
    @comment = current_user.comments.create(comment_params)
    @comment.asset_id = @asset.id
    if @comment.save
      flash[:notice] = "The comment has been posted."
      redirect_to project_asset_path(@project, @asset)
    else
      flash[:error] = "The comment could not be created, please try again."
      render 'new'
    end
  end

  def destroy
    @project = Project.friendly.find(params[:project_id])
    @asset = Asset.friendly.find(params[:asset_id])
    @comment = @asset.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = 'Comment removed.'
      redirect_to project_asset_path(@project, @asset)
    else
      flash[:error] = 'Comment cannot be removed'
      redirect_to project_asset_path(@project, @asset)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

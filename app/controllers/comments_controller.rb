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

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

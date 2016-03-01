class Assets::CommentsController < CommentsController
  before_action :set_commentable
  before_action :set_project

  private

  def set_commentable
    @commentable = Asset.friendly.find(params[:asset_id])
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end
end

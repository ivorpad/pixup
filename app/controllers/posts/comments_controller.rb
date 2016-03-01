class Posts::CommentsController < CommentsController
  before_action :set_commentable
  before_action :set_project

  private

  def set_commentable
    @commentable = Post.find(params[:post_id])
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end
end

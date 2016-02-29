class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @post = @project.posts.create(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = "Successfully created..."
      redirect_to [@project, @post]
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

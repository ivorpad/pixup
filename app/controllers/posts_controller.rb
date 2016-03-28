class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:category_id])
    @assets_content_type = Asset.pluck(:content_type).uniq
  end

  def show
    @post = Post.find(params[:id])
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:category_id])
  end

  def new
    @post = Post.new
  end

  def create
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:category_id])
    @post = @project.posts.create(post_params)
    @post.user_id = current_user.id
    @post.category_id = @category.id

    if @post.save
      flash[:notice] = "Successfully created..."
      redirect_to [@project, @category, @post]
    else
      render 'new'
    end
  end

  def edit
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:category_id])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @project = Project.friendly.find(params[:project_id])
    @category = Category.friendly.find(params[:category_id])

    if @post.update_attributes(post_params)
      flash[:notice] = "Successfully updated..."
      redirect_to [@project, @category, @post]
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

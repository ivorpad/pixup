class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @projects = @user.all_projects
  end

  def show
    @users = User.all
    @project = Project.friendly.find(params[:project_id])
    @members = User.where.not(id: @project.user.id)
    @categories = Category.all
    
    authorize @project
  end

  def new
    @project = Project.new

    authorize @project
  end

  def create
    @user = current_user
    @project = @user.created_projects.create(project_params)

    authorize @project
    if @project.save
      flash[:notice] = "The project has been created."
      redirect_to project_path(@project)
    else
      flash[:error] = "The project could not be created, please try again."
      render 'new'
    end
  end

  def edit
    @project = Project.friendly.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.friendly.find(params[:id])
    authorize @project
    if @project.update_attributes(project_params)
      flash[:notice] = "The project has been updated."
      redirect_to @project
    else
      flash[:error] = "The project cannot be updated."
      render @project
    end
  end

  def destroy
    @project = Project.friendly.find(params[:id])
    authorize @project
    if @project.destroy
      flash[:notice] = "The project has been deleted."
      redirect_to projects_path
    else
      flash[:error] = "The project cannot be deleted."
      render @project
    end
  end

  def add_member
    project = Project.friendly.find(params[:project_id])
    respond_to do |format|
      format.html { redirect_to project_path(project), notice: "This URL cannot be accessed directly." }
      format.js   { render nothing: true }
    end
  end

  def add_member_to_project
    @project = Project.friendly.find(params[:project_id])

    if @project.update_attributes(project_params)
      user_ids = params[:project][:user_ids]

      user_ids.map do |user|
        @project.collaborations.build(user_id: user)
      end

      flash[:notice] = "Member added."
      redirect_to project_path(@project.friendly_id)
    else
      flash[:danger] = "Member couldn't be added"
      render 'show'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status, :user_ids => [])
  end
end

class ProjectsController < ApplicationController
  # before_action :authenticate_user!

  def index
    # @projects = Project.all
    @projects = policy_scope(Project)
  end

  def show
    @project = Project.friendly.find(params[:project_id])
    @categories = Category.all
     authorize @project
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    @project.user_id = current_user.id
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

  private

  def project_params
    params.require(:project).permit(:title, :description, :favorite, :private)
  end
end

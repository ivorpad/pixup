class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    # @project = Project.new(project_params)
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:notice] = "The project has been created."
      redirect_to project_path(@project.id)
    else
      flash[:error] = "The project could not be created, please try again."
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      flash[:notice] = "The project has been updated."
      redirect_to @project
    else
      flash[:error] = "The project cannot be updated."
      render @project
    end
  end

  def destroy
    @project = Project.find(params[:id])

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

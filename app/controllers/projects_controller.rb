class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "The project has been created."
      redirect_to projects_path
    else
      flash[:error] = "The project could not be created, please try again."
      render 'new'
    end
  end

  def edit
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :favorite, :private)
  end
end

class ProjectsController < ApplicationController
  include ProjectsHelper

  def index
    unless current_user
      render template: "projects/no_user"
      return
    end
  end

  def show
    @project = Project.find_by id: params[:id]
  end

  def new
    unless current_user
      render template: "projects/no_user"
      return
    end
    @project = Project.new
  end

  def create
    unless current_user
      render template: "projects/no_user"
      return
    end
    @project = current_user.projects.build safe_params
    @project.owner = current_user
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def invite
    unless current_user
      render template: "projects/no_user"
      return
    end
    @project = Project.find_by id: params[:id]
    if @project
      @project.invite_people(emails_from_lines params[:invitations])
    end
  end

  private
  def safe_params
    params.require(:project).permit(:name)
  end
end

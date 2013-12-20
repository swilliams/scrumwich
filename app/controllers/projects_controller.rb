class ProjectsController < ApplicationController
  include ProjectsHelper

  before_action :find_project, only: [:show, :join]

  def index
    unless current_user
      render template: "projects/no_user"
      return
    end
  end

  def show
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

  def join
    if find_invitation.nil? or @invitation.project_id != @project.id
      redirect_to status: 404
      return
    end
    store_token @invitation.person.email
    @invitation.destroy
  end

  private
    def find_project
      @project = Project.find_by id: params[:id]
    end

    def safe_params
      params.require(:project).permit :name
    end

    def find_invitation
      @invitation = Invitation.find_by code: params[:code]
    end
end

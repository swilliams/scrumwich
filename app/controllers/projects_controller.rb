class ProjectsController < ApplicationController
  def index
    unless current_user
      render template: "projects/no_user"
      return
    end
  end

  def show
    @project = Project.find_by id: params[:id]
  end
end

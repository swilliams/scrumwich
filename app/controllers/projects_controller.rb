class ProjectsController < ApplicationController
  def index
    unless current_user
      render template: "projects/no_user"
      return
    end
  end

  def show
    @day = DateTime.now
  end
end

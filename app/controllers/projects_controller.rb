class ProjectsController < ApplicationController
  def index
    unless current_user
      render template: "projects/no_user"
      return
    end

  end
end

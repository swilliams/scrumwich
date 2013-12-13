class ProjectsController < ApplicationController
  def index
    unless current_user
      render template: "projects/no_user"
      return
    end
  end

  def show
    # TODO: move entries stuff to here
  end
end

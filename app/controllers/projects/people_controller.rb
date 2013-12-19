class Projects::PeopleController < ApplicationController
  include ProjectsHelper

  def destroy
    if find_project.nil? or find_person.nil?
      redirect_to status: 404
    else
      @project.people.delete @person
      respond_to do |format|
        format.html { redirect_to @project }
        format.json { render nothing: true }
      end
    end
  end

  def create
    if find_project.nil?
      redirect_to status: 404
    else
      @project.invite_people(emails_from_lines params[:invitations])
      respond_to do |format|
        format.html { redirect_to @project }
        format.json { render nothing: true }
      end
    end
  end

  private
    def find_project
      @project = Project.where(id: params[:project_id]).first
    end

    def find_person
      @person = @project.people.where(id: params[:id]).first
    end
end

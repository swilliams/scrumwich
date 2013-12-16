class Projects::EntriesController < ApplicationController
  before_action :get_project

  def today
    @entries = Entry.for_today
  end

  def new
    @person_name = cookies[:person_name]
    @person_email = cookies[:person_email]
    @entry = Entry.new
  end

  def create
    cookies[:person_email] = current_user.email
    @entry = @project.entries.build entry_params
    @entry.person = current_user
    if @entry.save
      redirect_to today_project_entries_path
    else
      @entry_errors = @entry.errors.full_messages
      render :new
    end
  end

  def show
    @day = DateTime.strptime(params[:id], "%m-%d-%Y")
    @entries = Entry.for_day @day
  end

  private
    def entry_params
      params.require(:entry).permit(:yesterday, :today, :block)
    end

    def get_project
      @project = Project.find_by(id: params[:project_id])
    end
end

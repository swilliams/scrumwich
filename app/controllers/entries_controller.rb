class EntriesController < ApplicationController
  def today
    @entries = Entry.for_today
  end

  def new
    @person_name = cookies[:person_name]
    @person_email = cookies[:person_email]
    @entry = Entry.new
  end

  def create
    p = Person.find_by(name: params[:person_name], email: params[:person_email])
    if p.nil?
      new_person = Person.new(name: params[:person_name], email: params[:person_email])
      if !new_person.save
        @person_errors = new_person.errors.full_messages
        @entry = Entry.new
        render :new
        return
      end
      p = new_person
    end
    cookies[:person_name] = p.name
    cookies[:person_email] = p.email
    @entry = p.entries.build entry_params
    if @entry.save
      redirect_to today_entries_path
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
end

class EntriesController < ApplicationController
  def today
    @entries = Entry.for_today
  end

  def new
    @entry = Entry.new
  end

  def create
    p = Person.find_by(name: params[:person_name], email: params[:person_email])
    if p.nil?
      p = Person.create(name: params[:person_name], email: params[:person_email])
      if !p
        render :new
        return
      end
    end
    @entry = p.entries.build entry_params
    if @entry.save
      redirect_to today_entries_path
    else
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

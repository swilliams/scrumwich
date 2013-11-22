class EntriesController < ApplicationController
  def today
    @entries = Entry.for_today
  end

  def new
    @entry = Entry.new
  end
end

class EntriesController < ApplicationController
  def today
    @entries = Entry.for_today
  end
end

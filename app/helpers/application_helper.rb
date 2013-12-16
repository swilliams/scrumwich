module ApplicationHelper
  attr_accessor :current_user

  def current_user
    return @current_user if @current_user
    email = retrieve_token
    @current_user = Person.find_by(email: email)
    @current_user
  end

  def long_formatted_date date
    date.strftime "%B %d, %Y"
  end

  def short_formatted_date date
    date.strftime "%m-%d-%Y"
  end

  private
  def retrieve_token
    cookies[:person_email]
  end
end


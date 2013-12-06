module ApplicationHelper
  attr_accessor :current_user

  def current_user
    return @current_user if @current_user
    email = retrieve_token
    @current_user = Person.find_by(email: email)
    @current_user
  end

  private
  def retrieve_token
    cookies[:person_email]
  end
end


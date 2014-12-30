class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def redirect_with_alert(object, message, location)
    flash[:alert] = message

    respond_with object, :location => location
  end

  def redirect_with_notice(object, message, location)
    flash[:notice] = message

    respond_with object, :location => location
  end
  alias :notice_redirect :redirect_with_notice

end

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # makes the helper_methods defined in the controller available for the views
  helper_method :logged_in?, :current_user

  # Logs in the given user
  #
  # @param [User] user
  #
  # @return [Hash] current session
  def login(user)
    session[:user_id] = user.id
  end

  # End the session of the user
  #
  # @return [void]
  def logout!
    session[:user_id] = nil
  end

  # Finds the current logged in user by the sessions user_id and sets the current user
  #
  # @return [User] current logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Checks whether the user is logged in or not
  #
  # @return [Boolean]
  def logged_in?
    !!current_user
  end

  # Check if the user is logged in or not
  #
  # @return [void]
  def require_login
    return if logged_in?

    flash[:danger] = t('.signin_required')
    redirect_to new_session_path
  end

  # No record matched in the database
  #
  # @return [void]
  def record_not_found
    render template: 'error_pages/404', layout: false, status: :not_found
  end

end

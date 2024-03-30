module SpecTestHelper

  # Creates a user session
  #
  # @param [User] user
  #
  # @return [void]
  def login(user)
    post sessions_path, params: { session: { email: user.email, password: "Password11$$" } }
  end

  # Sets the current logged in user
  #
  # @return [User]
  def current_user
    User.find(session[:user_id])
  end

end

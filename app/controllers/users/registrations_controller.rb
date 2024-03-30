# Manages user Registrations
class Users::RegistrationsController < ApplicationController

  # Render the user registration form
  #
  # @return [void]
  def new
    # instantiates the User model here
    @user = User.new
  end

  # Saves the new resource to the database(persistent)
  #
  # @return [void]
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = t('.signed_up_but_unconfirmed')
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  # Strong parameters/ Whitelist the users parameters
  #
  # @return [ApplicationController::Parameters] params
  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end

end

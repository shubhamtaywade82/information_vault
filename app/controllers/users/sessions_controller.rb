# Manages the User login and logout operations
class Users::SessionsController < ApplicationController

  # Renders the Login form
  #
  # @return [void]
  def new; end

  # Creates a new session with the user_id
  #
  # @return [void]
  def create
    user = User.find_by(email: user_params[:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.confirmed?
        login user
        flash[:success] = t('.signed_in')
        redirect_to vault_items_path(user)
      else
        flash.now[:error] = t('.signed_up_but_unconfirmed')
        render 'new'
      end
    else
      flash.now[:danger] = t('invalid')
      render 'new'
    end
  end

  # Logs out the user from session / destroys the session
  #
  # @return [void]
  def destroy
    logout! if logged_in?
    flash[:success] = t('.signed_out')
    redirect_to root_path
  end

  private

  # Whitelist the parameters extracted from the parameters
  #
  # @return [ApplicationController::Parameters] params
  def user_params
    params.require(:session).permit(:email, :password)
  end

end

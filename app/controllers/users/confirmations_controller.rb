# Manages confirmation of the user's account
class Users::ConfirmationsController < ApplicationController

  # Updates the users confirmation status
  #
  # @return [void]
  def show
    user = User.where(confirmation_token: params[:id]).last
    if user
      user.confirm!
      flash[:success] = t('.account_confirmation')
      redirect_to new_session_path
    else
      flash[:danger] = t('.invalid')
      redirect_to root_url
    end
  end

end

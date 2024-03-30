# Manages Users Operations
class UsersController < ApplicationController

  before_action :require_login

  # Renders the index view by default
  #
  # @return [void]
  def index; end

  # Renders the information of the a specific user
  #
  # @return [void]
  def show; end

  # Render the edit user information form
  #
  # @return [void]
  def edit; end

  # Updates the information edited in the form to database
  #
  # @return [void]
  def update; end

  # Delete the user (Only the admin can perform this action)
  #
  # @return [void]
  def destroy; end

end

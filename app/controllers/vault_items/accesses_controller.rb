# Manages access to the VaultItem
class VaultItems::AccessesController < ApplicationController

  before_action :require_login

  before_action :restrict_unless_owner
  # List all the Accessors
  #
  # @return [void]
  def index
    @vault_accesses = vault_item_accesses
  end

  # Form to Grant access to the {User}
  #
  # @return [void]
  def new
    @vault_item_access = vault_item_accesses.new
  end

  # Create a new accessor
  #
  # @return [void]
  def create
    vault_item_access = vault_item.grant_access(vault_access_params[:accessor_id], vault_access_params[:expire_at])
    if vault_item_access
      flash[:notice] = t('.access_granted')
      redirect_to vault_item_accesses_path
    else
      flash[:danger] = t('.error_occured')
      render :new
    end
  end

  # Revoke the access
  #
  # @return [void]
  def destroy
    vault_item_access = vault_item_accesses.find(params[:id])
    vault_item_access.destroy
    flash[:success] = t('.revoke_access_success')
    redirect_to vault_item_accesses_path
  end

  private

  # {VaultItem} for the current user with :id from the URL params
  #
  # @return [VaultItem]
  def vault_item
    @vault_item = current_user.vault_items.where(id: params[:vault_item_id]).first
  end

  # List if accesses granted {VaultItem}
  #
  # @return [VaultItemAccess]
  def vault_item_accesses
    @vault_item_accesses = vault_item.accesses
  end

  # Accept parameters
  #
  # @return [ActionController::Parameters]
  def vault_access_params
    params.require(:vault_item_access).permit(:expire_at, :accessor_id)
  end

  # Checks if the User is the vault item owner
  #
  # @return [void]
  def restrict_unless_owner
    return if current_user.vault_items.find(params[:vault_item_id])

    flash[:danger] = t('.reject_item_access')
    render 'vault_items/verify'
  end

end

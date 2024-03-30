# Manages all the VaultItems operations
class VaultItemsController < ApplicationController

  # User required for these operations
  before_action :require_login

  # restrict access to the vault item
  before_action :restrict_unless_owner, only: %i[edit update destroy]

  # Lists all the {VaultItems}
  #
  # @return [void]
  def index
    @vault_items = accessible_vault_items
  end

  # Renders the Create VaultItem  form
  #
  # @return [void]
  def new
    @vault_item = vault_items.new
  end

  # Creates new VaultItem Object/Persistent
  #
  # @return [void]
  def create
    @vault_item = vault_items.new(vault_item_params)
    if @vault_item.save
      flash[:success] = t('.item_created_successfully')
      redirect_to vault_items_path
    else
      flash.now[:danger] = t('.error')
      render 'new'
    end
  end

  # Renders the edit form
  #
  # @return [void]
  def edit
    @vault_item = vault_item
  end

  # Update the existing Vault Items information
  #
  # @return [void]
  def update
    @vault_item = vault_item
    if @vault_item.update_attributes(vault_item_params)
      flash[:notice] = t('.item_update_successful')
      redirect_to vault_items_path
    else
      render :edit
    end
  end

  # Verify {User} to view the {VaultItemCredentials}
  #
  # @return [void]
  def verify_user
    if current_user.authenticate(params[:password])
      @vault_item = accessible_vault_items.where(id: params[:id]).first
      render 'vault_items/show'
    else
      render 'vault_items/verify'
    end
  end

  # Delete the Specific vault item and its contents
  #
  # @return [void]
  # @todo Authentication to delete the {VaultItem} remaining
  def destroy
    if vault_item
      vault_item.destroy
      flash[:success] = t('.success')
    else
      flash[:alert] = t('invalid_action')
    end
    redirect_to vault_items_path
  end

  private

  # Permits the parameters required
  #
  # @return [ApplicationController]
  def vault_item_params
    params.require(:vault_item).permit(
      :title, :item_type,
      vault_item_credentials_attributes: %i[
        id
        credential_attr_id
        value
        _destroy
      ]
    )
  end

  # Return collection of vault items accessible to the {User}
  #
  # @return [VaultItem]
  def accessible_vault_items
    VaultItem.where(
      user_id: current_user.id
    ).or(
      VaultItem.where(
        id: VaultItemAccess.select(:vault_item_id).where(
          accessor_id: current_user.id
        )
      )
    )
  end

  # Setting vault Item
  #
  # @return [VaultItem] VaultItem::ActiveRecord_AssociationRelation
  def vault_item
    @vault_item = vault_items.find(params[:id])
  end

  # Gets the Collection of users vaultitems
  #
  # @return [VaultItem] ActiveRecord::Associations::CollectionProxy
  def vault_items
    current_user.vault_items
  end

  # Checks if the User is the vault item owner
  #
  # @return [void]
  def restrict_unless_owner
    return if vault_item

    flash[:danger] = t('.reject_item_access')
    redirect_to vault_items_path
  end

end

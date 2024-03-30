class VaultAccessMailer < ApplicationMailer

  # Creates a message to be sent to accessor
  #
  # @param [VaultItemAccess] item_access
  #
  # @return [Message]
  def access_granted(item_access)
    @vault_access = item_access
    mail to: @vault_access.accessor.email, subject: 'New Vault Item Access'
  end

  # Creates a alert message for User
  #
  # @param [VaultItemAccess] vault_access
  #
  # @return [Message]
  def access_revoked(vault_access)
    @vault_access = vault_access
    mail to: @vault_access.accessor.email, subject: 'Revoked Vault Item Access'
  end

end

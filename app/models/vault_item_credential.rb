# == Schema Information
#
# Table name: vault_item_credentials
#
#  id                 :integer          not null, primary key
#  value              :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  credential_attr_id :integer
#  vault_item_id      :integer
#
# Indexes
#
#  index_vault_item_credentials_on_credential_attr_id  (credential_attr_id)
#  index_vault_item_credentials_on_vault_item_id       (vault_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (credential_attr_id => credential_attrs.id)
#  fk_rails_...  (vault_item_id => vault_items.id)
#

# Represents the information stored in the {VaultItem} with
# {CredentialAttr}
#
class VaultItemCredential < ApplicationRecord

  validates :value,
    presence: true,
    length: { minimum: 2, maximum: 1000 }

  validates :credential_attr_id,
    presence: true,
    uniqueness: {
      scope: :vault_item_id,
      message: :only_once
    }

  before_create :encrypt_value

  belongs_to :vault_item

  belongs_to :credential_attr

  # setter for value attribute
  #
  # @param [String] val
  #
  # @return [void] value
  # def value=(val)
  #   key = Rails.configuration.application['secret_key']
  #   crypt = ActiveSupport::MessageEncryptor.new(key)
  #   self[:value] = crypt.encrypt_and_sign(val)
  # end

  # Returns a decrypted value or nil for new record
  #
  # @return [String]
  def decrypted_value
    key = Rails.configuration.application['secret_key']
    crypt = ActiveSupport::MessageEncryptor.new(key)
    if value.nil?
      nil
    else
      crypt.decrypt_and_verify(value)
    end
  end

  private

  # Encrypts the value
  #
  # @return [String]
  def encrypt_value
    key = Rails.configuration.application['secret_key']
    crypt = ActiveSupport::MessageEncryptor.new(key)
    self.value = crypt.encrypt_and_sign(value)
  end

end

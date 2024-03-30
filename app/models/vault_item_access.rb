# == Schema Information
#
# Table name: vault_item_accesses
#
#  id            :integer          not null, primary key
#  expire_at     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accessor_id   :integer          not null
#  granted_by_id :integer          not null
#  vault_item_id :integer
#

# Represents the shared relation between the Owner{User} and the Accessor{User}
class VaultItemAccess < ApplicationRecord

  # acts_as_paranoid

  validates :vault_item_id,
    presence: true

  validates :granted_by_id,
    presence: true

  validates :accessor_id,
    presence: true,
    uniqueness: {
      scope: :vault_item_id,
      message: :already_has_access
    }

  validates :expire_at,
    presence: true

  validate :expiry_date_must_be_in_future

  after_create :send_access_granted_mail

  before_destroy :send_access_revoked_mail

  belongs_to :granted_by,
    class_name: 'User',
    foreign_key: :granted_by_id

  belongs_to :accessor,
    class_name: 'User',
    foreign_key: :accessor_id

  belongs_to :vault_item

  # Sends access granted Mail to user
  #
  # @return [void]
  def send_access_granted_mail
    VaultAccessMailer.access_granted(self).deliver_now
  end

  # Sends access revoked mail to user
  #
  # @return [void]
  def send_access_revoked_mail
    VaultAccessMailer.access_revoked(self).deliver_now
  end

  private

  # Validates the Expiry date of VaultItemAccess is in future
  #
  # @return [void]
  def expiry_date_must_be_in_future
    return unless expire_at.present? && (expire_at < Date.tomorrow)

    errors.add(:expire_at, :invalid_expiry)
  end

end

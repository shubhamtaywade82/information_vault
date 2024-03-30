# == Schema Information
#
# Table name: vault_items
#
#  id         :integer          not null, primary key
#  item_type  :integer          not null
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_vault_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# Represents the item that the user created and a way to access them
# from the database
#
class VaultItem < ApplicationRecord

  validates :title,
    length: { minimum: 2, maximum: 100 },
    presence: true

  validates :user_id,
    presence: true

  validates :item_type,
    presence: true

  # A vault item has a vault item type/domain
  has_enumeration_for :item_type,
    with: ItemType,
    create_helpers: true

  belongs_to :user

  # A vault item can jas many credentials
  has_many :vault_item_credentials,
    dependent: :destroy

  # Many users can have access to the vault Item
  has_many :accesses,
    class_name: VaultItemAccess,
    dependent: :destroy

  accepts_nested_attributes_for :vault_item_credentials,
    reject_if: :all_blank,
    allow_destroy: true

  validates_presence_of :vault_item_credentials, on: :create

  # Returns true if the {User}(accessor) is owner
  #
  # @param [User] accessor users trying to access this vault_item
  #
  # @return [Boolean]
  def can_be_managed_by?(accessor)
    return false unless accessor

    owner?(accessor) || accessor.shared_vault_items.include?(self)
  end

  # Returns true if the user is owner
  #
  # @param [User] user
  #
  # @return [Boolean]
  def owner?(accessor)
    return false unless accessor

    user.id == accessor.id
  end

  # Grants the accessor the access to the vault items
  #
  # @param [Integer] user_id Accessor id
  # @param [Time] expire_at
  #
  # @return [void]
  def grant_access(user_id, expire_at)
    vault_item_access = accesses.new(
      granted_by: user,
      accessor_id: user_id,
      expire_at: expire_at
    )

    vault_item_access&.save if vault_item_access.valid?
    vault_item_access
  end

end

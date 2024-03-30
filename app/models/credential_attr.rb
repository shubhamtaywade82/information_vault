# == Schema Information
#
# Table name: credential_attrs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

# Represents the credential attributes and relation with  the user
#
class CredentialAttr < ApplicationRecord

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 50 }

  # validates :user_id,
  #   presence: true

  belongs_to :user

end

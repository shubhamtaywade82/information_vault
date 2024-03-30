# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  confirmation_token :string(255)
#  confirmed_at       :datetime
#  email              :string(255)      not null
#  password_digest    :string(255)      not null
#  username           :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

# Represents actor who saves and shares VaultItem
class User < ActiveRecord::Base

  PASSWORD_REGEX = /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[#_$]).{8,32}/.freeze

  # performs validation for username attribute
  validates :username,
    presence: true,
    uniqueness: { case_sensitivity: false },
    length: { minimum: 2 }

  # Adds methods to set and authenticate against a BCrypt password
  has_secure_password
  validates :password,
    presence: true,
    format: {
      with: PASSWORD_REGEX,
      message: :invalid
    },
    length: { minimum: 8 },
    on: :create

  validates :email,
    email: { mode: :strict, require_fqdn: true },
    uniqueness: { case_sensitivity: false }

  # before saving email to the persistent storage perform the downcase on the email attribute
  before_save :write_email

  # before creating creating the record in the users table
  # perform or create the confirmation token
  before_create :write_confirmation_token

  after_create :send_confirmation_mail

  # A user can have one or more vault_items
  has_many :vault_items

  # A user can add one or more credential attributes
  has_many :credential_attrs

  # A user can have access to one or more vault items
  has_many :vault_item_accesses, foreign_key: 'accessor_id'

  has_many :shared_vault_items,
    class_name: 'VaultItem',
    through: :vault_item_accesses,
    source: :vault_item

  # Confirms the account if email links token and
  # the confirmation_token are same add set the confirm at
  #
  # @return [void]
  def confirm!
    update!(confirmed_at: Time.zone.now, confirmation_token: nil)
  end

  # Checks wether the current user is confirmed or not
  #
  # @return [Boolean]
  def confirmed?
    !confirmed_at.nil?
  end

  # Returns username with email
  #
  # @return [String]
  def username_email
    "#{username} - #{email}"
  end

  private

  # Sends the confirmation mail to the user
  #
  # @return [void]
  def send_confirmation_mail
    UserMailer.account_confirmation(self).deliver_now
  end

  # Converts email to all lower-case.
  #
  # @return [String] email to lowercase
  def write_email
    self.email = email.downcase
  end

  # Assigns the user confirmation token generated randomly
  #
  # @return [String]
  def new_token
    SecureRandom.urlsafe_base64.to_s if confirmation_token.blank?
  end

  # Assigns the new token to the confirmation attribute of User
  #
  # @return [String] confirmation Token
  def write_confirmation_token
    self.confirmation_token = new_token
  end

end

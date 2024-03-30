RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'constants' do
    describe 'User::PASSWORD_REGEX' do
      let(:password_regex) { User::PASSWORD_REGEX }
      it { expect('Password1$'.match(password_regex)).not_to be nil }
      it { expect('Password1'.match(password_regex)).to be nil }
      it { expect('Password$'.match(password_regex)).to be nil }
      it { expect('assword1$'.match(password_regex)).to be nil }
      it { expect('password1$'.match(password_regex)).to be nil }
      it { expect('password'.match(password_regex)).to be nil }
      it { expect('P1$'.match(password_regex)).to be nil }
    end
  end

  describe 'validations' do
    it { expect(user).to validate_uniqueness_of(:username) }
    it { expect(user).to validate_presence_of(:username) }
    it { expect(user).to validate_uniqueness_of(:email) }
    it { expect(user).to allow_value('testabc@undominated.com').for(:email) }
    it { expect(user).to_not allow_value('test@example').for(:email) }
    it { expect(user).to_not allow_value('railsapp').for(:email) }
    it { expect(user).to_not allow_value('s').for(:username) }
  end

  describe 'associations' do
    it { expect(user).to have_many(:vault_items) }
    it { expect(user).to have_many(:vault_item_accesses) }
    it { expect(user).to have_many(:credential_attrs) }
  end

  describe 'callbacks' do
    it { expect(user).to callback(:write_email).before(:save) }
    it { expect(user).to callback(:write_confirmation_token).before(:create) }
    it { expect(user).to callback(:send_confirmation_mail).after(:create) }
  end

  describe 'callbacks' do
    describe 'send_confirmation_mail' do
      it 'delivers an confirmation email (after_create)' do
        expect do
          User.create(attributes_for(:user))
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    describe 'write_confirmation_token' do
      it 'assigns confirmation_token (before_create)' do
        expect(user.confirmation_token).to be nil
        user = User.create attributes_for(:user)
        expect(user.confirmation_token).not_to be nil
      end
    end

    describe 'write_email' do
      let(:email) { 'ShubhaTaywade@gmail.com' }
      let(:user) { build(:user, email: email) }
      it 'converts the email to downcase(before_save)' do
        expect(user.email).to eq email
        user = create(:user, email: email)
        expect(user.email).to eq email.downcase
      end
    end
  end

  describe 'operations after registering' do
    let(:user) { create(:user) }
    describe '#confirm!' do
      it 'updates confirmation_token and confirmed_at' do
        expect(user.confirmation_token).not_to be nil
        expect(user.confirmed_at).to be nil
        user.confirm!
        expect(user.confirmation_token).to be nil
        expect(user.confirmed_at).not_to be nil
      end
    end

    describe '#confirmed?' do
      it 'returns boolean for confirmed or not' do
        expect(user.confirmed?).to be false
        user.confirm!
        expect(user.confirmed?).to be true
      end
    end

    describe '#username_email' do
      it 'Gives pair of username and email' do
        expect(user.username_email).to eq "#{user.username} - #{user.email}"
      end
    end
  end
end

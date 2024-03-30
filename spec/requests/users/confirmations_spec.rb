RSpec.describe 'Users::Confirmations', type: :request do
  let(:email) { 'testuser@gmail.com' }
  shared_examples 'confirms_user_account' do
    it 'confirms the user account' do
      create(:user, email: email)
      user = User.find_by(email: email)

      expect(user.confirmation_token).not_to be nil

      expect(user.confirmed_at).to be nil

      get "/confirmations/#{user.confirmation_token}",
        params: {
          email: email,
          id: user.confirmation_token
        }
      user = User.find_by(email: email)
      expect(user.confirmation_token).to be nil

      expect(user.confirmed_at).not_to be nil
    end
  end

  shared_examples 'does_not_confirm_user_account' do
    it 'does not confirm the user account' do
      create(:user, :confirmed, email: email)
      user = User.find_by(email: email)
      confirmation_token = user.confirmation_token
      user.update(confirmation_token: nil)


      get "/confirmations/#{confirmation_token}",
        params: {
          email: email,
          id: user.confirmation_token
        }
      user = User.find_by(email: email)
      expect(user.confirmation_token).to be nil

      expect(user.confirmed_at).not_to be nil
    end
  end

  context 'confirmation link is valid' do
    it_behaves_like 'confirms_user_account'
  end

  context 'confirmation link is invalid' do
    it_behaves_like 'does_not_confirm_user_account'
  end

  context 'already confirmed the user account' do
    it_behaves_like 'does_not_confirm_user_account'
  end
end

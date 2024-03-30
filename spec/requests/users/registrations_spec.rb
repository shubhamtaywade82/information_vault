RSpec.describe 'Users::Registrations', type: :request do
  let(:email) { 'testuser@gmail.com' }
  let(:password) { 'Password11$$' }

  let(:user_params) do
    {
      username: 'testuser',
      email: email,
      password: password,
      password_confirmation: password
    }
  end
  shared_examples 'creates_user_account' do
    it 'creates a user account' do
      get '/registrations/new'
      expect(response).to render_template(:new)

      expect do
        post '/registrations', params: { user: user_params }
      end.to change { User.count }.by(1)

      user = User.find_by(email: user_params[:email])
      expect(user.confirmation_token).not_to be nil

      expect(ActionMailer::Base.deliveries.count).to eq(1)

      confirmation_email = ActionMailer::Base.deliveries.last

      expect(confirmation_email.to).to include user.email

      expect(confirmation_email
        .parts.first.body.encoded).to include(confirmation_url(user
        .confirmation_token,
          email: user.email).to_s)
    end
  end

  shared_examples 'does_not_create_user_account' do
    it 'does not create a user account' do
      get '/registrations/new'
      expect(response).to render_template(:new)
      expect do
        post '/registrations',
          params: { user: invalid_user_params }
      end.not_to(change { User.count })
    end
  end

  context 'user submits valid information' do
    it_behaves_like 'creates_user_account'
  end

  context 'user submits invalid information' do
    let(:email) { 'testusergmail.com' }
    let(:password) { 'password' }
    it 'does not create a user account' do
      get '/registrations/new'
      expect(response).to render_template(:new)

      expect do
        post '/registrations',
          params: { user: user_params }
      end.not_to(change { User.count })
    end
  end

  context 'user submits existing email' do
    it 'does not create a user account' do
      get '/registrations/new'
      expect(response).to render_template(:new)

      create(:user, email: email)
      expect do
        post '/registrations',
          params: { user: user_params }
      end.not_to(change { User.count })
    end
  end
end

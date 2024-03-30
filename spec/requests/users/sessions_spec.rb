RSpec.describe 'Users::Sessions', type: :request do
  let(:email) { 'testuser@gmail.com' }
  let(:password) { 'Password11$$' }

  let(:session_params) { { email: email, password: password } }

  shared_examples 'creates_session' do
    it 'creates a session' do
      get '/sessions/new'
      expect(response).to render_template(:new)

      user = create(:user, :confirmed, email: email, password: password)
      post '/sessions', params: { session: session_params }
      expect(session[:user_id]).to eq(user.id)
    end
  end

  shared_examples 'does_not_create_session' do
    it 'does not create a session' do
      get '/sessions/new'
      expect(response).to render_template(:new)

      post '/sessions', params: { session: session_params }
      expect(session[:user_id]).to be nil
    end
  end

  context 'credentials are valid' do
    it_behaves_like 'creates_session'
  end

  context 'credentials are invalid' do
    context 'email does not exist' do
      let(:email) { '' }
      it_behaves_like 'does_not_create_session'
    end

    context 'password is incorrect' do
      let(:password) { 'assword1$$' }
      it_behaves_like 'does_not_create_session'
    end
  end

  context 'credentials not submitted' do
    let(:session_params) { { email: '', password: '' } }
    it_behaves_like 'does_not_create_session'
  end

  context 'account is not confirmed' do
    it_behaves_like 'does_not_create_session'
  end

  context 'session already exists' do
    it_behaves_like 'does_not_create_session'
  end

  context 'user is logged out' do
    it 'redirects to the login page' do
      get '/sessions/new'
      expect(response).to render_template(:new)

      user = create(:user, :confirmed, email: email, password: password)
      post '/sessions', params: { session: session_params }
      expect(session[:user_id]).to eq(user.id)

      delete "/sessions/#{user.id})"
      expect(session[:user_id]).to be nil
      expect(response).to redirect_to root_path
    end
  end
end

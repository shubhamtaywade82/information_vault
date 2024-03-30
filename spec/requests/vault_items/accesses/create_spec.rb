RSpec.describe 'VaultItems::Accesses#create' do


  shared_examples 'grants_access_to_user' do
    it 'grants access to user' do

    end
  end

  shared_examples 'does_not_grant_access' do
    it 'does not grant access to user' do
    end
  end

  context 'when user is the owner of the vault item' do
    context 'expiry date is in the future' do
      it_behaves_like 'grants_access_to_user'
    end

    context 'accessor does not have access' do
      it_behaves_like 'grants_access_to_user'
    end
  end

  context 'when user is not the owner' do
    it_behaves_like 'does_not_grant_access'
  end

  context 'when user already has the access' do
    it_behaves_like 'does_not_grant_access'
  end

  context 'when expiry date is in the past' do
    it_behaves_like 'does_not_grant_access'
  end
end

RSpec.describe 'VaultItemsController#edit', type: :request do
  let(:vault_item) { create(:vault_item_with_credentials, :cloud_workspace) }

  let(:user_with_no_access) { create(:user, :confirmed) }

  let(:accessor) { vault_item.user }

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(accessor)
  end

  shared_examples 'updates_vault_item' do
    it 'updates vault item' do
      
    end
  end

  shared_examples 'does_not_update_vault_item' do
    it 'does not update the vault item' do
    end
  end

  context 'when vault item exists' do
    it_behaves_like 'updates_vault_item'
  end

  context 'when user has access to the vault item' do
    it_behaves_like 'updates_vault_item'
  end

  context 'when user is not the owner' do
    it_behaves_like 'does_not_update_vault_item'
  end

  context 'when user does not have access' do
    it_behaves_like 'does_not_update_vault_item'
  end

  context 'when vault item does not exist' do
    it_behaves_like 'does_not_update_vault_item'
  end

  context 'when information is not valid' do
    it_behaves_like 'does_not_update_vault_item'
  end

  context 'whena not credentials are selected' do
    it_behaves_like 'does_not_update_vault_item'
  end
end

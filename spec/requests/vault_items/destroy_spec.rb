RSpec.describe 'VaultItemsController#destroy', type: :request do
  let(:owner) { create(:user, :confirmed) }
  let(:user_with_no_access) { create(:user, :confirmed) }

  let(:vault_item) do
    create(:vault_item_with_credentials, :api_integration, user: owner)
  end
  let(:accessor) { owner }

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(accessor)
  end

  shared_examples 'destroy_vault_item' do
    it 'destroys vault item' do
      expect(vault_item.user.id).to eq owner.id

      expect do
        delete vault_item_path(vault_item)
      end.to change { VaultItem.count }.by(-1)

      expect(VaultItemCredential.all).to be_empty
    end
  end

  shared_examples 'does_not_destroy_vault_item' do
    it 'does not destroy the vault item' do
      expect(vault_item.user.id).not_to eq user_with_no_access.id

      expect do
        delete vault_item_path(vault_item)
      end.to change { VaultItem.count }.by(0)

      expect(VaultItemCredential.all).not_to be_empty
    end
  end

  context 'when user is owner of vault item' do
    let(:accessor) { owner }
    it_behaves_like 'destroy_vault_item'
  end

  context 'when user has access of the vault item' do
    let(:accessor) { owner }
    it_behaves_like 'destroy_vault_item'
  end

  context 'when user is not the owner of the vault item' do
    let(:accessor) { user_with_no_access }
    it_behaves_like 'does_not_destroy_vault_item'
  end

  context 'when user does not have the access to the vault item' do
    let(:accessor) { user_with_no_access }
    it_behaves_like 'does_not_destroy_vault_item'
  end
end

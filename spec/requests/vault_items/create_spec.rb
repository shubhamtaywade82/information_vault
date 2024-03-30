RSpec.describe 'VaultItemsController#create', type: :request do
  let(:user) { create(:user, :confirmed) }

  let(:vault_item_params) do
    attributes_for(:vault_item_with_credentials, :mysql)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  shared_examples 'creates_vault_item' do
    it 'creates vault item' do
      get '/vault_items/new'
      expect(response).to render_template(:new)

      expect do
        post '/vault_items', params: { vault_item: vault_item_params }
      end.to change { VaultItem.count }.by(1)

      expect(VaultItem.last.can_be_managed_by?(user)).to be true
    end
  end

  shared_examples 'does_not_create_vault_item' do
    it 'does not create vault item' do
      get '/vault_items/new'
      expect(response).to render_template(:new)

      expect do
        post '/vault_items', params: { vault_item: vault_item_params }
      end.to change { VaultItem.count }.by(0)
    end
  end

  context 'when information is complete' do
    it_behaves_like 'creates_vault_item'
  end

  context 'when information is incomplete' do
    context 'when item type is not selected' do
      let(:vault_item_params) do
        attributes_for(:vault_item_with_credentials, item_type: nil)
      end
      it_behaves_like 'does_not_create_vault_item'
    end

    context 'when title is empty' do
      let(:vault_item_params) do
        attributes_for(:vault_item_with_credentials, title: '')
      end
      it_behaves_like 'does_not_create_vault_item'
    end

    context 'when credential is not added' do
      let(:vault_item_params) { attributes_for(:vault_item) }
      it_behaves_like 'does_not_create_vault_item'
    end
  end

  context 'when information invalid' do
    let(:vault_item_params) do
      attributes_for(:vault_item_with_credentials)
    end
    it_behaves_like 'does_not_create_vault_item'
  end
end

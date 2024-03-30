RSpec.describe 'VaultItems::Accesses#update' do
  shared_examples 'updates_expiry_date' do
    it 'updates expiry date'
  end

  shared_examples 'does_not_update_expiry_date' do
    it 'does not update the expiry date' do
    end
  end

  context 'when user is the owner' do
    context 'expiry date is in the future' do
      it_behaves_like 'updates_expiry_date'
    end
  end

  context 'when user is not the owner' do
    it_behaves_like 'does_not_update_expiry_date'
  end
end

RSpec.describe VaultItemAccess, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:vault_item_id) }
    it { is_expected.to validate_presence_of(:granted_by_id) }
    it { is_expected.to validate_presence_of(:accessor_id) }
    # it { is_expected.to validate_uniqueness_of(:accessor_id).scoped_to(:vault_item_id) }
    it { is_expected.to validate_presence_of(:expire_at) }
  end
end

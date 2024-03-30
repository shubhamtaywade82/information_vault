RSpec.describe VaultItem, type: :model do
  let(:owner) { create(:user) }

  let(:vault_item) { create(:vault_item_with_credentials, :mysql, user: owner) }

  let(:user_with_access) { create(:user) }

  let(:user_with_no_access) { create(:user) }

  before do
    vault_item.accesses.create(
      granted_by: owner,
      accessor: user_with_access,
      expire_at: Time.current + 2.days)
  end

  describe 'validations' do
    it do
      is_expected.to validate_length_of(:title).is_at_least(2).is_at_most(100)
    end
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:item_type) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:vault_item_credentials) }
    it { is_expected.to have_many(:accesses) }
  end

  describe 'accepts nested attributes for' do
    it { is_expected.to accept_nested_attributes_for(:vault_item_credentials) }
  end

  describe '#grant_access(user, expire_at)' do
    context 'user already has access' do
      it 'does not grant access to the user' do
        vault_item.grant_access(user_with_access, Time.current + 2.days)
        expect(vault_item.can_be_managed_by?(user_with_access)).to be true
      end
    end

    context 'user does not have the access' do
      it 'grants user access to the vault item' do
        vault_item.grant_access(user_with_no_access, Time.current + 2.days)
        expect(vault_item.can_be_managed_by?(user_with_no_access)).to be false
      end
    end
  end

  describe '#can_be_managed_by?(accessor)' do
    context 'accessor is the owner of vault_item' do
      it 'returns true' do
        expect(vault_item.can_be_managed_by?(owner)).to eq true
      end
    end

    context 'accessor has access to vault_item' do
      before do
        vault_item.grant_access(user_with_access.id, Time.current + 2.days)
      end
      it 'returns true' do
        expect(vault_item.can_be_managed_by?(user_with_access)).to eq true
      end
    end

    context 'accessor does not have access to vault_item' do
      it 'returns false' do
        expect(vault_item.can_be_managed_by?(user_with_no_access)).to eq false
      end
    end

    context 'accessor is nil' do
      it 'returns false' do
        expect(vault_item.can_be_managed_by?(nil)).to eq false
      end
    end
  end
end

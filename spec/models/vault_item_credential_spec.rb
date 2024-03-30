RSpec.describe VaultItemCredential, type: :model do
  let(:in_mem_vault_item) { build(:vault_item_with_credentials, :mysql) }
  let(:persist_vault_item) { create(:vault_item_with_credentials, :mysql) }

  let(:vault_item_credential) { in_mem_vault_item.vault_item_credentials.last }

  let(:saved_credential) { persist_vault_item.vault_item_credentials.last }

  let(:value) { vault_item_credential.value }

  describe 'encrypt_value' do
    context 'when value not empty' do
      it 'encrypt the value' do
        expect(vault_item_credential.value).to eq value

        expect(saved_credential.value).not_to eq value
      end
    end

    context 'when value empty' do
      it 'do not save credential' do
        # @todo to implement this test case an empty value trait to be define
      end
    end
  end

  describe '#decrypted_value' do
    it 'decrypts the value' do
      expect(saved_credential.value).not_to eq value

      expect(saved_credential.decrypted_value).to eq value
    end
  end
end

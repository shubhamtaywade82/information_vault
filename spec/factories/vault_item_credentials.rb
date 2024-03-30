FactoryBot.define do
  factory :vault_item_credential do
    vault_item

    attributes = YAML.load_file(Rails.root.join('db', 'credential_attr.yml'))

    # iterates the attributes to create dynamic vault_item_credentials
    attributes['name'].each do |attr_name|
      trait attr_name.to_sym do
        credential_attr_id { CredentialAttr.find_by(name: attr_name).id }
      end
    end

    # trait for credential with url
    trait :url do
      credential_attr_id { CredentialAttr.find_by(name: 'url').id }
    end
  end
end

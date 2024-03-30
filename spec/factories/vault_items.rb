FactoryBot.define do
  factory :vault_item do
    user
    transient do
      type { ItemType.to_a[rand(12)] }
    end
    title { "John Snow's Credentials #{type[0]}" }
    item_type { type[1] }

    factory :vault_item_with_credentials do
      trait :api_integration do
        title { "John Snow's Credentials for api integrations" }
        item_type { ItemType::API_INTEGRATION }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :url,
              value: 'mysql://localhost:3306/mysql',
              vault_item: vault_item),
            attributes_for(:vault_item_credential,
              :token,
              vault_item: vault_item,
              value: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9eyJpc3MiOi'\
                'J0b3B0YWwuY29tIiwiZXhwIjoxNDI2NDIwODAwL'),
            attributes_for(:vault_item_credential,
              :password,
              value: 'Pjohns1$',
              vault_item: vault_item)
          ]
        end
      end

      trait :cloud_workspace do
        title { "John Snow's Credentials for cloud workspace" }
        item_type { ItemType::CLOUD_WORKSPACE }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$')
          ]
        end
      end

      trait :git do
        title { "John Snow's Credentials for git repository" }
        item_type { ItemType::GIT }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :ssh_key,
              vault_item: vault_item,
              value: 'ssh-rsa AAAAB3NzaC1== phpseclib-generated-key'),
            attributes_for(:vault_item_credential,
              :email,
              vault_item: vault_item,
              value: 'john_snow@gmail.com'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$')
          ]
        end
      end

      trait :gmail do
        title { "John Snow's Credentials for gmail" }
        item_type { ItemType::GMAIL }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :email,
              vault_item: vault_item,
              value: 'john_snow@gmail.com'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item:
              vault_item,
              value: 'Pjohns1$')
          ]
        end
      end

      trait :microsoft_office do
        title { "John Snow's Credentials for microsoft office" }
        item_type { ItemType::MICROSOFT_OFFICE }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :email,
              vault_item: vault_item,
              value: 'john_snow@gmail.com'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$')
          ]
        end
      end

      trait :mysql do
        title { "John Snow's Credentials for mysql" }
        item_type { ItemType::MYSQL }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :host,
              vault_item: vault_item,
              value: 'localhost'),
            attributes_for(:vault_item_credential,
              :port,
              vault_item: vault_item,
              value: '3306'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$'),
            attributes_for(:vault_item_credential,
              :database_name,
              vault_item: vault_item,
              value: 'test_database')
          ]
        end
      end

      trait :oracle do
        title { "John Snow's Credentials for oracle" }
        item_type { ItemType::ORACLE }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$'),
            attributes_for(:vault_item_credential,
              :host,
              vault_item: vault_item,
              value: 'localhost'),
            attributes_for(:vault_item_credential,
              :port,
              vault_item: vault_item,
              value: '3306'),
            attributes_for(:vault_item_credential,
              :database_name,
              vault_item: vault_item,
              value: 'test_database')
          ]
        end
      end

      trait :php_my_admin do
        title { "John Snow's Credentials for php admin" }
        item_type { ItemType::PHP_MY_ADMIN }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$'),
            attributes_for(:vault_item_credential,
              :database_name,
              vault_item: vault_item,
              value: 'test_database')
          ]
        end
      end

      trait :postgres do
        title { "John Snow's Credentials for postgres" }
        item_type { ItemType::POSTGRES }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$'),
            attributes_for(:vault_item_credential,
              :host,
              vault_item: vault_item,
              value: 'localhost'),
            attributes_for(:vault_item_credential,
              :port,
              vault_item: vault_item,
              value: '3306'),
            attributes_for(:vault_item_credential,
              :database_name,
              vault_item: vault_item,
              value: 'test_database')
          ]
        end
      end

      trait :sql_developer do
        title { "John Snow's Credentials for sql developers" }
        item_type { ItemType::SQL_DEVELOPER }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$')
          ]
        end
      end

      trait :ssh do
        title { "John Snow's Credentials for ssh" }
        item_type { ItemType::SSH }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :private_key,
              vault_item: vault_item,
              value: '-----BEGIN RSA PRIVATE KEY--w9RZz+/6rCJ4p0=-END RSA PRIVATE KEY-----'),
            attributes_for(:vault_item_credential,
              :public_key,
              vault_item: vault_item,
              value: '-----BEGIN PUBLIC KEY-MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC-END PUBLIC KEY-----')
          ]
        end
      end

      trait :system do
        title { "John Snow's Credentials for system" }
        item_type { ItemType::SYSTEM }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :ip,
              vault_item: vault_item,
              value: '192.168.0.1'),
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$')
          ]
        end
      end

      trait :web_portal do
        title { "John Snow's Credentials for web portal" }
        item_type { ItemType::WEB_PORTAL }
        vault_item_credentials_attributes do |vault_item|
          [
            attributes_for(:vault_item_credential,
              :username,
              vault_item: vault_item,
              value: 'john_snow'),
            attributes_for(:vault_item_credential,
              :url,
              vault_item: vault_item,
              value: 'mysql://localhost:3306/mysql'),
            attributes_for(:vault_item_credential,
              :password,
              vault_item: vault_item,
              value: 'Pjohns1$')
          ]
        end
      end
    end
  end
end

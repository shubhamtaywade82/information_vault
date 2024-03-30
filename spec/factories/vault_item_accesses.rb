FactoryBot.define do
  factory :vault_item_access do
    transient do
      vault_item { create(:vault_item) }
      user_without_access { create(:user, :confirmed, confirmation_token: nil) }
    end
    vault_item
    granted_by { vault_item.user }
    accessor { user_without_access }
    expire_at { Time.current + 2.days }
    trait :expired do
      expire_at { Time.current - 2.days }
    end
  end
end

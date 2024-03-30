# Enumeration List of different types of VaultItems
class ItemType < EnumerateIt::Base
  associate_values(
    api_integration: 1,
    cloud_workspace: 2,
    git: 3,
    gmail: 4,
    microsoft_office: 5,
    mysql: 6,
    oracle: 7,
    php_my_admin: 8,
    postgres: 9,
    sql_developer: 10,
    ssh: 11,
    system: 12,
    web_portal: 13
  )
end

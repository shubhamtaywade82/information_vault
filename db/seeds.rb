require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(
#   [
#     { username: 'shubhamtaywade', email: 'shubhamtaywade@gmail.com', password: 'Password11$$',
#       confirmed_at: Time.zone.now }
#   ]
# )

# 50.times do
#   User.create(
#     username: Faker::Name.name,
#     email: Faker::Internet.free_email,
#     password: 'Password11$$',
#     confirmed_at: Time.zone.now
#   )
# end

attrs_name = YAML.load_file(Rails.root.join('db', 'credential_attr.yml'))
attrs_name['name'].each do |name|
  CredentialAttr.create(name: name)
end

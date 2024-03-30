RSpec.configure do |config|
  # config.before(:all) { load Rails.root.join('db', 'seeds.rb') }

  # config.before(:suite) do
  #   DatabaseCleaner.clean_with(:truncation)
  #   load Rails.root.join('db', 'seeds.rb')
  #   # CredentialAttr.create!(YAML::load_file(Rails.root.join('db', 'credential_attr.yml')))
  # end

  # config.before(:each) do
  #   DatabaseCleaner.strategy = :transaction
  # end

  # # config.before(:each, js: true) do
  # #   DatabaseCleaner.strategy = :truncation
  # # end

  # config.before(:each) do
  #   DatabaseCleaner.start
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    load Rails.root.join('db', 'seeds.rb')
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

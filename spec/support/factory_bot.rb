RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  # config.before(:each) do
  #   host! 'localhost:3000'
  # end
  config.before(:each, type: :request) do
    host! 'localhost:3000'
  end
end

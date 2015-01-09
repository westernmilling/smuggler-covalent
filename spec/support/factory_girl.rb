FactoryGirl::SyntaxRunner.send(:include, Smuggler::FactoryGirlHelpers)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Smuggler::FactoryGirlHelpers
end

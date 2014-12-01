require 'devise'

include Warden::Test::Helpers
Warden.test_mode!

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:user, :admin) # Using factory girl as an example
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end

RSpec.configure do |config|
  # config.include Devise::TestHelpers, :type => :controller
  # config.extend ControllerMacros, :type => :controller
end
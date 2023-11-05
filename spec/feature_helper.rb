require 'rails_helper'

require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  config.include Capybara::DSL, :type => :api
  config.include Warden::Test::Helpers
end

Capybara.server_port = 9887

def json
  JSON.parse(page.body)
end
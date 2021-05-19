require 'rails_helper.rb'

RSpec.configure do |config|
  config.include AcceptanceMacros, type: :feature
  config.include ActionController, type: :feature
  config.use_transactional_fixtures = false # !!!изменяем из-за AJAX
  Capybara.javascript_driver = :webkit
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
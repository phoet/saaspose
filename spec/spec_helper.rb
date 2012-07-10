require "saaspose"
require "pry"
require "vcr"

# See https://github.com/myronmarston/vcr
VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr_cassettes"
  c.hook_into :webmock
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.around(:each, :vcr => true) do |example|
    name = example.metadata[:full_description].downcase.gsub(/\W+/, "_").split("_", 2).join("/")
    VCR.use_cassette(name, :record => :new_episodes, :match_requests_on => [:host, :path]) do
      example.call
    end
  end
end

# Setting for CI
ENV["SAASPOSE_APPSID"] ||= "appsid"
ENV["SAASPOSE_APPKEY"] ||= "appkey"

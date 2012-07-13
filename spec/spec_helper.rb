require "pry"
require "vcr"
require "saaspose"

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

REMOTE_ROOT_DIR = ""

PNG_PATH = "/tmp/test.png"
PDF_PATH = "/tmp/test.pdf"

TEST_PDF_NAME = "saaspose_test.pdf"
TEST_PPT_NAME = "saaspose_test.ppt"
TEST_DOC_NAME = "saaspose_test.doc"
TEST_XLS_NAME = "saaspose_test.xls"


def configure_client
  Saaspose::Configuration.configure do |config|
    config.app_sid = ENV["SAASPOSE_APPSID"]
    config.app_key = ENV["SAASPOSE_APPKEY"]
    config.logger  = nil
  end
end

def ensure_remote_file(test_file)
  VCR.use_cassette("ensure_remote_file #{test_file}", :record => :new_episodes, :match_requests_on => [:host, :path]) do
    unless Saaspose::Storage.files.map(&:name).include?(test_file)
      puts "uploading #{test_file} for testing purposes"
      Saaspose::Storage.upload(fixture_path(test_file), REMOTE_ROOT_DIR)
    end
  end
end

def fixture_path(name)
  File.expand_path("fixtures/#{name}", File.dirname(__FILE__))
end

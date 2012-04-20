require "spec_helper"

describe "saasposesdk" do
  PNG_PATH = "/tmp/test.png"
  TEST_PDF_NAME = "saaspose_test.pdf"

  let(:pdf_converter) { Pdf::Convertor.new(TEST_PDF_NAME) }
  let(:test_pdf_path) { File.expand_path("../fixtures/#{TEST_PDF_NAME}", File.dirname(__FILE__)) }

  before(:all) do
    configure_client
    ensure_remote_file
  end

  context "pdf" do
    before(:each) do
      FileUtils.rm(PNG_PATH) if File.exists?(PNG_PATH)
    end

    it "should generate a pdf", :vcr => true do
      pdf_converter.convert(PNG_PATH,'png','1','800','600')
      File.exists?(PNG_PATH).should be_true
    end
  end
end

def configure_client
  Common::Product.setBaseProductUri("http://api.saaspose.com/v1.0")
  Common::SaasposeApp.new(ENV["SAASPOSE_APPSID"], ENV["SAASPOSE_APPKEY"])
end

def ensure_remote_file
  VCR.use_cassette("ensure_remote_file", :record => :new_episodes, :match_requests_on => [:host, :path]) do
    unless Storage::Folder.getFiles("").map(&:Name).include?(TEST_PDF_NAME)
      puts "uploading #{TEST_PDF_NAME} for testing purposes"
      Storage::Folder.uploadFile(test_pdf_path, "")
    end
  end
end

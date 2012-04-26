require "spec_helper"

describe "saasposesdk" do
  PNG_PATH = "/tmp/test.png"
  PDF_PATH = "/tmp/test.pdf"
  TEST_PDF_NAME = "saaspose_test.pdf"
  TEST_PPT_NAME = "saaspose_test.ppt"

  let(:pdf_converter) { Pdf::Convertor.new(TEST_PDF_NAME) }
  let(:ppt_converter) { Slides::Convertor.new(TEST_PPT_NAME) }

  before(:all) do
    configure_client
    [TEST_PDF_NAME, TEST_PPT_NAME].each { |path| ensure_remote_file(path) }
  end

  before(:each) do
    [PNG_PATH, PDF_PATH].each { |path| FileUtils.rm(path) if File.exists?(path) }
  end

  context "pdf" do
    it "should generate a png from a remote pdf", :vcr => true do
      pdf_converter.convert(PNG_PATH, 'png', '1', '800', '600')
      File.exists?(PNG_PATH).should be_true
    end

    it "should read the number of pages from a remote pdf", :vcr => true do
      pdf_converter.getPageCount.should eql(1)
    end
  end

  context "slides" do
    it "should generate a pdf from a remote ppt", :vcr => true do
      ppt_converter.convert(PDF_PATH, 'pdf')
      File.exists?(PDF_PATH).should be_true
    end
  end
end

def configure_client
  Common::Product.setBaseProductUri("http://api.saaspose.com/v1.0")
  Common::SaasposeApp.new(ENV["SAASPOSE_APPSID"], ENV["SAASPOSE_APPKEY"])
end

def ensure_remote_file(test_file)
  VCR.use_cassette("ensure_remote_file #{test_file}", :record => :new_episodes, :match_requests_on => [:host, :path]) do
    unless Storage::Folder.getFiles("").map(&:Name).include?(test_file)
      puts "uploading #{test_file} for testing purposes"
      Storage::Folder.uploadFile(File.expand_path("../fixtures/#{test_file}", File.dirname(__FILE__)), "")
    end
  end
end

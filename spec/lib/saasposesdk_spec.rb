require "spec_helper"

describe "saasposesdk" do
  REMOTE_ROOT_DIR = ""

  PNG_PATH = "/tmp/test.png"
  PDF_PATH = "/tmp/test.pdf"

  TEST_PDF_NAME = "saaspose_test.pdf"
  TEST_PPT_NAME = "saaspose_test.ppt"
  TEST_DOC_NAME = "saaspose_test.doc"
  TEST_XLS_NAME = "saaspose_test.xls"

  let(:pdf_converter) { Pdf::Convertor.new(TEST_PDF_NAME) }
  let(:ppt_converter) { Slides::Convertor.new(TEST_PPT_NAME) }
  let(:doc_converter) { Words::Convertor.new(TEST_DOC_NAME) }
  let(:xls_converter) { Cells::Convertor.new(TEST_XLS_NAME) }

  before(:all) do
    configure_client
    [TEST_PDF_NAME, TEST_PPT_NAME, TEST_DOC_NAME, TEST_XLS_NAME].each { |path| ensure_remote_file(path) }
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

  context "words" do
    it "should generate a pdf from a remote doc", :vcr => true do
      doc_converter.convert(PDF_PATH, 'pdf')
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "cells" do
    it "should generate a pdf from a remote xls", :vcr => true do
      xls_converter.convert(PDF_PATH, 'pdf')
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "storage" do
    it "should upload a file to the root dir", :vcr => true do
      resp = Storage::Folder.uploadFile(fixture_path(TEST_PDF_NAME), REMOTE_ROOT_DIR)
      resp.should match("<Status>OK</Status>")
    end

    it "should get a list of files from the root dir", :vcr => true do
      files = Storage::Folder.getFiles(REMOTE_ROOT_DIR)
      files.first.should be_an_instance_of(Saasposesdk::File)
      files.map(&:Name).should include(TEST_PDF_NAME)
    end
  end
end

def configure_client
  # Saasposesdk::Configuration.configure do |config|
  #   config.product_uri = "http://api.saaspose.com/v1.0"
  #   config.app_sid     = ENV["SAASPOSE_APPSID"]
  #   config.app_key     = ENV["SAASPOSE_APPKEY"]
  # end
  Common::Product.setBaseProductUri("http://api.saaspose.com/v1.0")
  Common::SaasposeApp.new(ENV["SAASPOSE_APPSID"], ENV["SAASPOSE_APPKEY"])
end

def ensure_remote_file(test_file)
  VCR.use_cassette("ensure_remote_file #{test_file}", :record => :new_episodes, :match_requests_on => [:host, :path]) do
    unless Storage::Folder.getFiles("").map(&:Name).include?(test_file)
      puts "uploading #{test_file} for testing purposes"
      Storage::Folder.uploadFile(fixture_path(test_file), REMOTE_ROOT_DIR)
    end
  end
end

def fixture_path(name)
  File.expand_path("../fixtures/#{name}", File.dirname(__FILE__))
end
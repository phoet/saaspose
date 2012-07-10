require "spec_helper"

describe "saaspose" do
  REMOTE_ROOT_DIR = ""

  PNG_PATH = "/tmp/test.png"
  PDF_PATH = "/tmp/test.pdf"

  TEST_PDF_NAME = "saaspose_test.pdf"
  TEST_PPT_NAME = "saaspose_test.ppt"
  TEST_DOC_NAME = "saaspose_test.doc"
  TEST_XLS_NAME = "saaspose_test.xls"

  before(:all) do
    configure_client
    [TEST_PDF_NAME, TEST_PPT_NAME, TEST_DOC_NAME, TEST_XLS_NAME].each { |path| ensure_remote_file(path) }
  end

  before(:each) do
    [PNG_PATH, PDF_PATH].each { |path| FileUtils.rm(path) if File.exists?(path) }
  end

  context "pdf" do
    it "should generate a png from a remote pdf", :vcr => true do
      Saaspose::Pdf.convert(TEST_PDF_NAME, PNG_PATH, 'png', '1', '800', '600')
      File.exists?(PNG_PATH).should be_true
    end

    it "should read the number of pages from a remote pdf", :vcr => true do
      Saaspose::Pdf.page_count(TEST_PDF_NAME).should eql(1)
    end
  end

  context "slides" do
    it "should generate a pdf from a remote ppt", :vcr => true do
      Saaspose::Slides.convert(TEST_PPT_NAME, PDF_PATH, 'pdf')
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "words" do
    it "should generate a pdf from a remote doc", :vcr => true do
      Saaspose::Words.convert(TEST_DOC_NAME, PDF_PATH, 'pdf')
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "cells" do
    it "should generate a pdf from a remote xls", :vcr => true do
      Saaspose::Cells.convert(TEST_XLS_NAME, PDF_PATH, 'pdf')
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "storage" do
    it "should upload a file to the root dir", :vcr => true do
      resp = Saaspose::Storage.uploadFile(fixture_path(TEST_PDF_NAME), REMOTE_ROOT_DIR)
      resp.should match("<Status>OK</Status>")
    end

    it "should get a list of files from the root dir", :vcr => true do
      files = Saaspose::Storage.getFiles(REMOTE_ROOT_DIR)
      files.first.should be_an_instance_of(Saaspose::File)
      files.map(&:Name).should include(TEST_PDF_NAME)
    end
  end

  context "utils" do
    before(:each) do
      Saaspose::Configuration.configure do |config|
        config.app_sid = "SAASPOSE_APPSID"
        config.app_key = "SAASPOSE_APPKEY"
      end
    end

    let(:url) { "http://example.com/path?uschi=true&a_param=yes" }
    it "should sign a uri" do
      Saaspose::Utils.sign(url).should eql("http://example.com/path?uschi=true&a_param=yes&appSID=SAASPOSE_APPSID&signature=zl%2BjolbjggyKZ31QgflGVILu%2F0I")
    end
  end
end

def configure_client
  Saaspose::Configuration.configure do |config|
    config.product_uri = "http://api.saaspose.com/v1.0"
    config.app_sid     = ENV["SAASPOSE_APPSID"]
    config.app_key     = ENV["SAASPOSE_APPKEY"]
  end
end

def ensure_remote_file(test_file)
  VCR.use_cassette("ensure_remote_file #{test_file}", :record => :new_episodes, :match_requests_on => [:host, :path]) do
    unless Saaspose::Storage.getFiles("").map(&:Name).include?(test_file)
      puts "uploading #{test_file} for testing purposes"
      Saaspose::Storage.uploadFile(fixture_path(test_file), REMOTE_ROOT_DIR)
    end
  end
end

def fixture_path(name)
  File.expand_path("../fixtures/#{name}", File.dirname(__FILE__))
end

require "spec_helper"

describe Saaspose do

  before(:all) do
    configure_client
    [TEST_PDF_NAME, TEST_PPT_NAME, TEST_DOC_NAME, TEST_XLS_NAME].each { |path| ensure_remote_file(path) }
  end

  before(:each) do
    configure_client
    [PNG_PATH, PDF_PATH].each { |path| FileUtils.rm(path) if File.exists?(path) }
  end

  context "pdf" do
    let(:page_number) { 1 }
    let(:options) {{:format => :doc}}

    it "should generate a png from a page of a remote pdf", :vcr => true do
      Saaspose::Pdf.convert_page(TEST_PDF_NAME, PNG_PATH, page_number)
      File.exists?(PNG_PATH).should be_true
    end

    it "should read the number of pages from a remote pdf", :vcr => true do
      Saaspose::Pdf.page_count(TEST_PDF_NAME).should eql(1)
    end
    
    it "should generate a doc from a remote pdf", :vcr => true do
      Saaspose::Pdf.convert(TEST_PDF_NAME, DOC_PATH, options)
      File.exists?(DOC_PATH).should be_true
    end
  end

  context "slides" do
    it "should generate a pdf from a remote ppt", :vcr => true do
      Saaspose::Slides.convert(TEST_PPT_NAME, PDF_PATH)
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "words" do
    it "should generate a pdf from a remote doc", :vcr => true do
      Saaspose::Words.convert(TEST_DOC_NAME, PDF_PATH)
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "cells" do
    it "should generate a pdf from a remote xls", :vcr => true do
      Saaspose::Cells.convert(TEST_XLS_NAME, PDF_PATH)
      File.exists?(PDF_PATH).should be_true
    end
  end

  context "storage" do
    
    it "should create a folder on the root of the remote storage", :vcr => true do
      resp = Saaspose::Storage.create_folder("test", "")
      resp.should match("OK")
    end

    it "should upload a file to the root dir", :vcr => true do
      resp = Saaspose::Storage.upload(fixture_path(TEST_PDF_NAME), REMOTE_ROOT_DIR)
      resp.should match("{\"Code\":200,\"Status\":\"OK\"}")
    end

    it "should get a list of files from the root dir", :vcr => true do
      files = Saaspose::Storage.files(REMOTE_ROOT_DIR)
      files.first.should be_an_instance_of(Saaspose::Storage::RemoteFile)
      files.map(&:name).should include(TEST_PDF_NAME)
    end
  end
end

require "spec_helper"

describe "saasposesdk" do
  before(:all) do
    Common::Product.setBaseProductUri("http://api.saaspose.com/v1.0")
    Common::SaasposeApp.new(ENV["SAASPOSE_APPSID"], ENV["SAASPOSE_APPKEY"])
  end

  context "pdf" do
    it "should generate a pdf" do
      pdfConvertor = Pdf::Convertor.new('test_data/test.pdf')
      pdfConvertor.convert('/tmp/test.png','png','1','800','600')
    end
  end
end

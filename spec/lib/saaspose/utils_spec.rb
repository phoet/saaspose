require "spec_helper"

describe Saaspose::Utils do
  before(:each) do
    Saaspose::Configuration.configure do |config|
      config.app_sid = "SAASPOSE_APPSID"
      config.app_key = "SAASPOSE_APPKEY"
    end
  end

  context "signing" do
    let(:signed_url) { "http://api.saaspose.com/v1.0/path?uschi=true&a_param=yes&appSID=SAASPOSE_APPSID&signature=kOJ7Xip6DwLMBOS7ZX9%2FxCkPn1w" }

    it "should sign a uri" do
      Saaspose::Utils.sign("path", {:uschi => true, :a_param => :yes}).should eql(signed_url)
    end
  end
end

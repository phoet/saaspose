require 'rubygems'
require 'rest_client'
require 'json'
require 'openssl'
require 'base64'
require 'uri'
require 'rexml/document'

# This module provide common classes and methods to be ued by other SDK modules
module Common

  # This class allows you to set the base host Saaspose URI
  class Product
    # Sets the host product URI.
    def self.setBaseProductUri(productURI)
      Saasposesdk::Configuration.configure :product_uri => productURI
    end
  end

  # This class allows you to set the AppSID and AppKey values you get upon signing up
  class SaasposeApp
    def initialize(appSID,appKey)
      Saasposesdk::Configuration.configure :app_sid => appSID, :app_key => appKey
    end
  end
end

require "confiture"
require "logger"

module Saaspose
  class Configuration
    include Confiture::Configuration
    confiture_allowed_keys(:product_uri, :app_sid, :app_key, :logger)
    confiture_mandatory_keys(:product_uri, :app_sid, :app_key)
    confiture_defaults(:product_uri => "http://api.saaspose.com/v1.0/", :logger => Logger.new(STDERR))
  end
end

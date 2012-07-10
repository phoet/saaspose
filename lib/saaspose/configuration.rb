require "logger"

module Saaspose
  class Configuration
    class << self
      attr_accessor :product_uri
      attr_accessor :app_sid, :app_key
      attr_accessor :logger
      attr_accessor :init

      def configure(options={})
        init_config
        if block_given?
          yield self
        else
          options.each do |key, value|
            send(:"#{key}=", value)
          end
        end
        self
      end

      def reset
        init_config(true)
      end

      private

      def init_config(force=false)
        return if @init && !force
        @init     = true
        @product_uri  = "http://api.saaspose.com/v1.0"
        @app_key      = ""
        @app_sid      = ""
        @logger        = Logger.new(STDERR)
      end
    end
  end
end

module Saasposesdk
  class Configuration
    class << self
      attr_accessor :product_uri
      attr_accessor :app_sid, :app_key
      attr_accessor :logger

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

      def init_config
        @product_uri  = ""
        @app_key      = ""
        @app_sid      = ""
        @logger        = Logger.new(STDERR)
      end
    end
  end
end

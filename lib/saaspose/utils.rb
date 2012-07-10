require 'cgi'
require 'rest_client'
require 'openssl'
require 'base64'
require 'uri'

module Saaspose
  class Utils
    class << self
      # Signs a URI with your appSID and Key.
      # * :url describes the URL to sign
      def sign(url)
        url = URI.escape(url)
        parsed_url = URI.parse(url)

        url_to_sign =''
        if parsed_url.query.nil?
          url_to_sign = parsed_url.scheme+"://"+ parsed_url.host + parsed_url.path + "?appSID=" + Configuration.app_sid
        else
          url_to_sign = parsed_url.scheme+"://"+ parsed_url.host + parsed_url.path + '?' + parsed_url.query + "&appSID=" + Configuration.app_sid
        end

        # create a signature using the private key and the URL
        raw_signature = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), Configuration.app_key, url_to_sign)

        #Convert raw to encoded string
        signature = Base64.strict_encode64(raw_signature).tr('+/','-_')

        #remove invalid character
        signature = signature.gsub(/[=_-]/,'=' => '', '_' => '%2f', '-' => '%2b')

        #Define expression
        pat = /%[0-9a-f]{2}/

        #Replace the portion matched to the above pattern to upper case
        6.times do
          signature = signature.sub(pat, pat.match(signature).to_s.upcase)
        end

        # prepend the server and append the signature.
        url_to_sign + "&signature=#{signature}"
      end

      def parse_date(date_string)
        seconds_since_epoch = date_string.scan(/[0-9]+/)[0].to_i
        Time.at((seconds_since_epoch-(21600000 + 18000000))/1000)
      end

      def call(uri, options, file)
        url = "#{Configuration.product_uri}#{uri}"
        url << "?" << options.map{|key, value| "#{key}=#{CGI::escape(value.to_s)}"}.join("&") if options
        signed_url = Utils.sign(url)
        response   = RestClient.get(signed_url, :accept => 'application/json')
        Utils.save_file(response, file)
      end

      def save_file(response_stream, local_file)
        File.open(local_file, "wb") { |file| file.write(response_stream.body) }
      end
    end
  end
end

module Saasposesdk
  class Slides
    class << self
      def convert(name, localFile, saveFormat)
        urlDoc = Configuration.product_uri + '/slides/' + name + '?format=' + saveFormat
        signedURL = Common::Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Common::Utils.saveFile(response,localFile)
      end
    end
  end
end

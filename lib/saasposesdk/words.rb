module Saasposesdk
  class Words
    class << self
      def convert(name, localFile, saveFormat)
        urlDoc = Configuration.product_uri + '/words/' + name + '?format=' + saveFormat
        signedURL = Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Utils.saveFile(response, localFile)
      end
    end
  end
end

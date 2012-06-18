module Saasposesdk
  class Cells
    class << self
      def convert(name, localFile, saveFormat)
        urlDoc = Configuration.product_uri + '/cells/' + name + '?format=' + saveFormat
        signedURL = Common::Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Common::Utils.saveFile(response,localFile)
      end
    end
  end
end

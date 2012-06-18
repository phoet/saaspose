module Saasposesdk
  class Pdf
    class << self
      def convert(name, localFile, saveImageFormat, pageNumber, height, width)
        urlDoc = Configuration.product_uri + '/pdf/' + name + '/pages/' + pageNumber + '?format=' + saveImageFormat + '&width=' + width + '&height=' + height
        signedURL = Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Utils.saveFile(response, localFile)
      end

      def page_count(name)
        urlPage = Configuration.product_uri + '/pdf/' + name + '/pages'
        signedURL = Utils.sign(urlPage)
        Utils.getFieldCount(signedURL, '/SaaSposeResponse/Pages/Page')
      end
    end
  end
end

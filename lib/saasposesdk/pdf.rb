module Saasposesdk
  class Pdf
    class << self
      def convert(name, localFile, saveImageFormat, pageNumber, height, width)
        urlDoc = Configuration.product_uri + '/pdf/' + name + '/pages/' + pageNumber + '?format=' + saveImageFormat + '&width=' + width + '&height=' + height
        signedURL = Common::Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Common::Utils.saveFile(response, localFile)
      end

      def page_count(name)
        urlPage = Configuration.product_uri + '/pdf/' + name + '/pages'
        signedURL = Common::Utils.sign(urlPage)
        Common::Utils.getFieldCount(signedURL, '/SaaSposeResponse/Pages/Page')
      end
    end
  end
end

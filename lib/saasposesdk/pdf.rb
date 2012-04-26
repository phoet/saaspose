module Saasposesdk
  class Pdf
    class << self
      def convert(name, localFile,saveImageFormat,pageNumber,height,width)
        urlDoc = $productURI + '/pdf/' + name + '/pages/' + pageNumber + '?format=' + saveImageFormat + '&width=' + width + '&height=' + height
        signedURL = Common::Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Common::Utils.saveFile(response,localFile)
      end

      def page_count(name)
        urlPage = $productURI + '/pdf/' + name + '/pages'
        signedURL = Common::Utils.sign(urlPage)
        count = Common::Utils.getFieldCount(signedURL,'/SaaSposeResponse/Pages/Page')
        return count
      end
    end
  end
end

module Saasposesdk
  class Pdf
    class << self
      def convert(name, local_file, save_image_format, page_number, height, width)
        url_doc = Configuration.product_uri + '/pdf/' + name + '/pages/' + page_number + '?format=' + save_image_format + '&width=' + width + '&height=' + height
        signed_url = Utils.sign(url_doc)
        response = RestClient.get(signed_url, :accept => 'application/json')
        Utils.saveFile(response, local_file)
      end

      def page_count(name)
        url_page = Configuration.product_uri + '/pdf/' + name + '/pages'
        signed_url = Utils.sign(url_page)
        Utils.getFieldCount(signed_url, '/SaaSposeResponse/Pages/Page')
      end
    end
  end
end

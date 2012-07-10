require "rexml/document"

module Saaspose
  class Pdf
    class << self
      def convert(name, local_file, save_image_format, page_number, height, width)
        url_doc = Configuration.product_uri + '/pdf/' + name + '/pages/' + page_number + '?format=' + save_image_format + '&width=' + width + '&height=' + height
        signed_url = Utils.sign(url_doc)
        response = RestClient.get(signed_url, :accept => 'application/json')
        Utils.save_file(response, local_file)
      end

      def page_count(name)
        url_page = Configuration.product_uri + '/pdf/' + name + '/pages'
        signed_url = Utils.sign(url_page)
        response = RestClient.get(signed_url, :accept => 'application/xml')
        REXML::Document.new(response.body).elements.size
      end
    end
  end
end

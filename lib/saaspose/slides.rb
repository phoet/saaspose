module Saaspose
  class Slides
    class << self
      def convert(name, local_file, save_format)
        url_doc = Configuration.product_uri + '/slides/' + name + '?format=' + save_format
        signed_url = Utils.sign(url_doc)
        response = RestClient.get(signed_url, :accept => 'application/json')
        Utils.saveFile(response, local_file)
      end
    end
  end
end

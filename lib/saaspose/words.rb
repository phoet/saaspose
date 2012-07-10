module Saaspose
  class Words
    class << self
      def convert(name, local_file, save_format)
        urlDoc = Configuration.product_uri + '/words/' + name + '?format=' + save_format
        signedURL = Utils.sign(urlDoc)
        response = RestClient.get(signedURL, :accept => 'application/json')
        Utils.saveFile(response, local_file)
      end
    end
  end
end

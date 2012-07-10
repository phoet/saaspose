require "json"

module Saaspose
  class Storage
    File = Struct.new(:name, :folder, :modified, :size)

    class << self
      def upload(local_file_path, remote_folder_path)
        file_name = ::File.basename(local_file_path)
        url_file = "#{Configuration.product_uri}/storage/file/#{remote_folder_path.empty? ? "" : "/#{remote_folder_path}" }#{file_name}"
        signed_url = Utils.sign(url_file)
        RestClient.put(signed_url, ::File.new(local_file_path, 'rb'))
      end

      def files(remote_folder_path="")
        url_folder = "#{Configuration.product_uri}/storage/folder"
        url_folder << "/#{remote_folder_path}" unless remote_folder_path.empty?

        signed_url  = Utils.sign(url_folder)
        response    = RestClient.get(signed_url, :accept => 'application/json')
        result      = JSON.parse(response.body)

        result["Files"].map do |entry|
          File.new(entry["Name"], entry["IsFolder"], Utils.parse_date(entry["ModifiedDate"]), entry["Size"])
        end
      end
    end
  end
end

module Saaspose
  class Storage
    class << self
      def uploadFile(local_file_path, remote_folder_path)
        file_name = ::File.basename(local_file_path)
        url_file = "#{Configuration.product_uri}/storage/file/#{remote_folder_path.empty? ? "" : "/#{remote_folder_path}" }#{file_name}"
        signed_url = Utils.sign(url_file)
        Utils.uploadFileBinary(local_file_path, signed_url)
      end

      def getFiles(remote_folder_path)
        url_folder = "#{Configuration.product_uri}/storage/folder"
        url_folder << "/#{remote_folder_path}" unless remote_folder_path.empty?

        signed_url  = Utils.sign(url_folder)
        response    = RestClient.get(signed_url, :accept => 'application/json')
        result      = JSON.parse(response.body)

        result["Files"].map do |entry|
          file = File.new
          file.Name         = entry["Name"]
          file.IsFolder     = entry["IsFolder"]
          file.Size         = entry["Size"]
          file.ModifiedDate = Utils.parse_date(entry["ModifiedDate"])
          file
        end
      end
    end
  end
end

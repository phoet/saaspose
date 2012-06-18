module Saasposesdk
  class Storage
    class << self
      def uploadFile(local_file_path, remote_folder_path)
        file_name = ::File.basename(local_file_path)
        url_file = Configuration.product_uri + '/storage/file/' + file_name
        if not remote_folder_path.empty?
          url_file = Configuration.product_uri + '/storage/file/' + remote_folder_path + '/' + file_name
        end
        signed_url = Utils.sign(url_file)
        Utils.uploadFileBinary(local_file_path,signed_url)
      end

      def getFiles(remote_folder_path)
        url_folder = Configuration.product_uri + '/storage/folder'
        url_file = ''
        if not remote_folder_path.empty?
          url_file = Configuration.product_uri + '/storage/folder/' + remote_folder_path
        end
        signed_url = Utils.sign(url_folder)
        response = RestClient.get(signed_url, :accept => 'application/json')
        result = JSON.parse(response.body)
        apps = Array.new(result["Files"].size)

        for i in 0..result["Files"].size - 1
          apps[i] = File.new
          apps[i].Name = result["Files"][i]["Name"]
          apps[i].IsFolder = result["Files"][i]["IsFolder"]
          apps[i].Size = result["Files"][i]["Size"]
          apps[i].ModifiedDate = Utils.parse_date(result["Files"][i]["ModifiedDate"])
        end
        return apps
      end
    end
  end
end

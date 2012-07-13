require "rest-client"

module Saaspose
  class Storage
    RemoteFile = Struct.new(:name, :folder, :modified, :size)

    class << self
      def upload(local_file_path, remote_folder_path)
        file_name = File.basename(local_file_path)
        url_file = "storage/file/#{remote_folder_path.empty? ? "" : "/#{remote_folder_path}" }#{file_name}"
        signed_url = Utils.sign(url_file)
        RestClient.put(signed_url, File.new(local_file_path, 'rb'), :accept => 'application/json')
      end

      def files(remote_folder_path="")
        uri = "storage/folder"
        uri << "/#{remote_folder_path}" unless remote_folder_path.empty?
        result = Utils.call_and_parse(uri)

        result["Files"].map do |entry|
          seconds_since_epoch = entry["ModifiedDate"].scan(/[0-9]+/)[0].to_i
          date = Time.at((seconds_since_epoch-(21600000 + 18000000))/1000)
          RemoteFile.new(entry["Name"], entry["IsFolder"], date, entry["Size"])
        end
      end
    end
  end
end

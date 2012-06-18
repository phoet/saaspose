module Saasposesdk
  class Storage
    class << self
      def uploadFile(localFilePath, remoteFolderPath)
        fileName = ::File.basename(localFilePath)
        urlFile = Configuration.product_uri + '/storage/file/' + fileName
        if not remoteFolderPath.empty?
          urlFile = Configuration.product_uri + '/storage/file/' + remoteFolderPath + '/' + fileName
        end
        signedURL = Utils.sign(urlFile)
        Utils.uploadFileBinary(localFilePath,signedURL)
      end

      def getFiles(remoteFolderPath)
        urlFolder = Configuration.product_uri + '/storage/folder'
        urlFile = ''
        if not remoteFolderPath.empty?
          urlFile = Configuration.product_uri + '/storage/folder/' + remoteFolderPath
        end
        signedURL = Utils.sign(urlFolder)
        response = RestClient.get(signedURL, :accept => 'application/json')
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

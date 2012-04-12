require_relative 'saaspose_common'

# This module provides wrapper classes to work with Saaspose.Storage resources
module Storage  
     # This class represents File Saaspose URI data
     class AppFile
         attr_accessor :Name, :IsFolder, :ModifiedDate, :Size
     end
     
	 # This class represents IsExist Saaspose URI data
     class FileExist
         attr_accessor :IsExist, :IsFolder
     end

	 # This class represents Disc Saaspose URI data
     class Disc
         attr_accessor :TotalSize, :UsedSize
     end
	 
     # This class provides functionality to manage files in a Remote Saaspose Folder
	 class Folder
	     # Uploads file from the local path to the remote folder.
		 # * :localFilePath represents full local file path and name
         # * :remoteFolderPath represents remote folder relative to the root. Pass empty string for the root folder.		 
         def self.uploadFile(localFilePath,remoteFolderPath)
             fileName = File.basename(localFilePath)
			 urlFile = $productURI + '/storage/file/' + fileName
			 if not remoteFolderPath.empty?
			     urlFile = $productURI + '/storage/file/' + remoteFolderPath + '/' + fileName
			 end
             signedURL = Common::Utils.sign(urlFile)
             Common::Utils.uploadFileBinary(localFilePath,signedURL)			 
         end
		 # Retrieves Files and Folder information from a remote folder. The method returns an Array of AppFile objects.
		 # * :remoteFolderPath represents remote folder relative to the root. Pass empty string for the root folder.
         def self.getFiles(remoteFolderPath)
             urlFolder = $productURI + '/storage/folder'
             urlFile = ''
             urlExist = ''
             urlDisc = ''
			 if not remoteFolderPath.empty?
			     urlFile = $productURI + '/storage/folder/' + remoteFolderPath 
			 end             
			 signedURL = Common::Utils.sign(urlFolder)
             response = RestClient.get(signedURL, :accept => 'application/json')
             result = JSON.parse(response.body)
             apps = Array.new(result["Files"].size)

             for i in 0..result["Files"].size - 1
                 apps[i] = AppFile.new
                 apps[i].Name = result["Files"][i]["Name"]
                 apps[i].IsFolder = result["Files"][i]["IsFolder"]
                 apps[i].Size = result["Files"][i]["Size"]
                 apps[i].ModifiedDate = Common::Utils.parse_date(result["Files"][i]["ModifiedDate"])
             end
             return apps	 
         end
     end
end

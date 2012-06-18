require_relative 'saaspose_common'

# This module provides wrapper classes to work with Saaspose.Storage resources
module Storage
  # This class provides functionality to manage files in a Remote Saaspose Folder
  class Folder
    # Uploads file from the local path to the remote folder.
    # * :localFilePath represents full local file path and name
    # * :remoteFolderPath represents remote folder relative to the root. Pass empty string for the root folder.
    def self.uploadFile(localFilePath,remoteFolderPath)
      Saasposesdk::Storage.uploadFile(localFilePath,remoteFolderPath)
    end

    # Retrieves Files and Folder information from a remote folder. The method returns an Array of AppFile objects.
    # * :remoteFolderPath represents remote folder relative to the root. Pass empty string for the root folder.
    def self.getFiles(remoteFolderPath)
      Saasposesdk::Storage.getFiles(remoteFolderPath)
    end
  end
end

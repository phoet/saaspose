require_relative 'saaspose_storage'

# This module provide wrapper classes to work with Saaspose.Words resources
module Words
    # This class provides functionality for converting Word Documents to other supported formats.
    class Convertor  
        # Constructor for the Convertor Class.
        # * :name represents the name of the Word Document on the Saaspose server 		
	    def initialize(name)  
             # Instance variables   
             @name = name
        end
	     # Converts the file available at Saaspose Storage and saves converted file locally.
		 # * :localFile represents converted local file path and name
         # * :saveFormat represents the converted format. For a list of supported formats, please visit 
		 #  http://saaspose.com/docs/display/words/document		 
        def convert(localFile,saveFormat)
		    urlDoc = $productURI + '/words/' + @name + '?format=' + saveFormat
		    signedURL = Common::Utils.sign(urlDoc)
		    response = RestClient.get(signedURL, :accept => 'application/json')
			Common::Utils.saveFile(response,localFile)
        end		
    end  
end

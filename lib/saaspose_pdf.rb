require_relative 'saaspose_storage'

# This module provide wrapper classes to work with Saaspose.Pdf resources
module Pdf
    # This class provides functionality for converting PDF Documents to other supported formats.
    class Convertor
	    # Constructor for the Convertor Class.
        # * :name represents the name of the PDF Document on the Saaspose server 		
        def initialize(name)  
           # Instance variables   
           @name = name
        end
	     # Converts the file available at Saaspose Storage and saves converted file locally.
		 # * :localFile represents converted local file path and name
         # * :saveImageFormat represents the converted image format. For a list of supported image formats, please visit 
		 #  http://saaspose.com/docs/display/pdf/page
         # * :pageNumber represents the page number in the PDF document
         # * :height represents height of the converted image
         # * :width represents width of the converted image 		 
        def convert(localFile,saveImageFormat,pageNumber,height,width)
		    urlDoc = $productURI + '/pdf/' + @name + '/pages/' + pageNumber + '?format=' + saveImageFormat + '&width=' + width + '&height=' + height
		    signedURL = Common::Utils.sign(urlDoc)
		    response = RestClient.get(signedURL, :accept => 'application/json')
			Common::Utils.saveFile(response,localFile)
        end
		# Retruns the number of pages in a PDF document
        def getPageCount
		    urlPage = $productURI + '/pdf/' + @name + '/pages'
			signedURL = Common::Utils.sign(urlPage)
			count = Common::Utils.getFieldCount(signedURL,'/SaaSposeResponse/Pages/Page')
			return count 
        end		
    end  
end

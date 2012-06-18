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
      Saasposesdk::Pdf.convert(@name, localFile, saveImageFormat, pageNumber, height, width)
    end

    # Retruns the number of pages in a PDF document
    def getPageCount
      Saasposesdk::Pdf.page_count(@name)
    end
  end
end

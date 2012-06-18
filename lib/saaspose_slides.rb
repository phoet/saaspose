require_relative 'saaspose_storage'

# This module provide wrapper classes to work with Saaspose.Slides resources
module Slides
  # This class provides functionality for converting PowerPoint Presentations to other supported formats.
  class Convertor
    # Constructor for the Convertor Class.
    # * :name represents the name of the PowerPoint Presentation on the Saaspose server
    def initialize(name)
      # Instance variables
      @name = name
    end

    # Converts the file available at Saaspose Storage and saves converted file locally.
    # * :localFile represents converted local file path and name
    # * :saveFormat represents the converted format. For a list of supported formats, please visit
    #  http://saaspose.com/docs/display/slides/presentation+Resource
    def convert(localFile,saveFormat)
      Saasposesdk::Slides.convert(@name, localFile, saveFormat)
    end
  end
end

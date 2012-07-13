module Saaspose
  class Slides
    class << self
      def convert(name, file, options={:format=>:pdf})
        url = "slides/#{name}"
        Utils.call_and_save(url, options, file)
      end
    end
  end
end

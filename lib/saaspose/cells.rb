module Saaspose
  class Cells
    class << self
      def convert(name, file, options={:format=>:pdf})
        url = "/cells/#{name}"
        Utils.call(url, options, file)
      end
    end
  end
end

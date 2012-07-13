module Saaspose
  class Words
    class << self
      def convert(name, file, options={:format=>:pdf})
        url = "words/#{name}"
        Utils.call_and_save(url, options, file)
      end
    end
  end
end

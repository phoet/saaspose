module Saaspose
  class Pdf
    class << self
      def convert(name, file, page_number, options={:format=>:png, :height=>800, :width=>600})
        url = "pdf/#{name}/pages/#{page_number}"
        Utils.call_and_save(url, options, file)
      end

      def page_count(name)
        url = "pdf/#{name}/pages"
        result = Utils.call_and_parse(url)
        result["Pages"]["Links"].size
      end
    end
  end
end

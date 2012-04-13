require 'rubygems'
require 'rest_client'
require 'json'
require 'openssl'
require 'base64'
require 'uri'
require 'rexml/document'

# This module provide common classes and methods to be ued by other SDK modules
module Common
    
    # This class allows you to set the base host Saaspose URI
	class Product
     # Sets the host product URI.
	def self.setBaseProductUri(productURI)
		     $productURI = productURI
		end
	end

	# This class allows you to set the AppSID and AppKey values you get upon signing up
    class SaasposeApp
         def initialize(appSID,appKey)  
		     $appSID = appSID
		     $appKey = appKey
         end	
	end
		
    # This class provides common methods to be repeatedly used by other wrapper classes
    class Utils
	     # Signs a URI with your appSID and Key.
		 # * :url describes the URL to sign
         def self.sign(url)
  	         url = URI.escape(url)
  	         parsedURL = URI.parse(url)
  
  	         urlToSign =''
  	         if parsedURL.query.nil? 
		         urlToSign = parsedURL.scheme+"://"+ parsedURL.host + parsedURL.path + "?appSID=" + $appSID
  	         else
		         urlToSign = parsedURL.scheme+"://"+ parsedURL.host + parsedURL.path + '?' + parsedURL.query + "&appSID=" + $appSID
  	         end

  	         # create a signature using the private key and the URL
  	         rawSignature = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), $appKey, urlToSign)
  
  	         #Convert raw to encoded string
  	         signature = Base64.strict_encode64(rawSignature).tr('+/','-_')
  
  	         #remove invalid character 
  	         signature = signature.gsub(/[=_-]/,'=' => '','_' => '%2f','-' => '%2b')

  	         #Define expression
  	         pat = Regexp.new("%[0-9a-f]{2}")

	         #Replace the portion matched to the above pattern to upper case
	         for i in 0..5
  	             signature = signature.sub(pat,pat.match(signature).to_s.upcase)
	         end

  	         # prepend the server and append the signature.
  	         signedUrl = urlToSign + "&signature=#{signature}"  
  	         return signedUrl
         end
    
	     # Parses JSON date value to a valid date format
		 # * :datestring holds the JSON Date value
	     def self.parse_date(datestring)
             seconds_since_epoch = datestring.scan(/[0-9]+/)[0].to_i
             return Time.at((seconds_since_epoch-(21600000 + 18000000))/1000)
         end

         # Uploads a binary file from the client system
		 # * :localfile holds the local file path alongwith name
		 # * :url holds the required url to use while uploading the file to Saaspose Storage		 
         def self.uploadFileBinary(localfile,url)
		     RestClient.put( url,File.new(localfile, 'rb'))
         end
         
         # Gets the count of a particular field in the response
		 # * :localfile holds the local file path alongwith name
		 # * :url holds the required url to use while uploading the file to Saaspose Storage		 		 
	     def self.getFieldCount(url,fieldName)	    
		     response = RestClient.get(url, :accept => 'application/xml')
		     doc = REXML::Document.new(response.body)
		     pages = []		
		     doc.elements.each(fieldName) do |ele|
                 pages << ele.text
             end
             return pages.size
	     end
		 # Saves the response stream to a local file.
		 def self.saveFile(responseStream,localFile)
		     open(localFile, "wb") do |file|
                 file.write(responseStream.body)
              end
		 end
    end
end

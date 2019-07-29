require 'net/http'
require 'net/http/post/multipart'

module Wistia
  class Uploader < Wistia::Base    
    # Wistia requires that the upload be done with multi-part form data
    # ActiveResource does not support this, so we'll have to use the net library
    # For this class make the self.site a URI rather than string to work with HTTP

    self.site = URI("https://upload.wistia.com/")
    
    def self.upload(attributes={})
      attributes.merge!('api_password' => Wistia.password)
      
      # Check for test mode and override the project_id
      if Wistia.test?
        attributes.merge!('project_id' => Wistia.test_project_id)
      end

      # Build the encrypted request and send it
      http = Net::HTTP.new(self.site.host, self.site.port)
      http.use_ssl = true

      request = Net::HTTP::Post::Multipart.new self.site.request_uri, attributes
      # Get back a response with a JSON body that has all of our media infos from Wistia
      response = http.request(request)
    end # upload
  end # Uploader
end # Wistia
module Wistia
  class Uploader < Wistia::Base

    # require 'net/https'
    # require 'net/http/post/mutipart'

    self.site = "https://upload.wistia.com/"

    
    def self.upload(attributes={})
      attributes.merge!('api_password' => Wistia.password)
      http = Net::HTTP.new(URI(self.site).host, URI(self.site).port)
      http.use_ssl = true

      request = Net::HTTP::Post::Multipart.new uri.request_uri, attributes
      response = http.request(request)

    end # upload

    # def self.new(attributes={}, persisted = false)
    #   if !attributes.key?(:file)
    #     raise ArgumentError.new("you must provide a file path with a key for the file")
    #   end
    #   super
    # end # initialize

  end # Uploader
end # Wistia
module Wistia
  class Uploader < Wistia::Base

    self.site = "https://upload.wistia.com/"


    # def self.new(attributes={}, persisted = false)
    #   if !attributes.key?(:file)
    #     raise ArgumentError.new("you must provide a file path with a key for the file")
    #   end
    #   super
    # end # initialize

  end # Uploader
end # Wistia
module Wistia
  module Projects
    class Sharing < Wistia::Base

      if Wistia.test?
        self.site = "#{Wistia::API_BASE_URL}projects/#{self.test_project_id}/"
      else
        self.site = "#{Wistia::API_BASE_URL}projects/:project_id/"
      end

      def self.get_site
        self.site
      end # get_site

      def to_json(options = {})
        self.attributes.to_json(options)
      end
    end
  end
end

module Wistia
  module Projects
    class Sharing < Wistia::Base

      def self.site
        if Wistia.test?
          self.site = "#{Wistia::API_BASE_URL}projects/#{Wistia.test_project_id}/"
        else
          self.site = "#{Wistia::API_BASE_URL}projects/:project_id/"
        end

        super
      end # site

      def to_json(options = {})
        self.attributes.to_json(options)
      end
    end
  end
end

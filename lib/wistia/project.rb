module Wistia
  class Project < Wistia::Base

    def self.site
      if Wistia.test?
        self.site = "#{Wistia::API_BASE_URL}projects/#{Wistia.test_project_id}/"
      else
        self.site = "#{Wistia::API_BASE_URL}projects/:project_id/"
      end

      super
    end # site
  end
end

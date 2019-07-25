module Wistia
  class Media < Wistia::Base
    self.collection_name = 'medias'


    def self.find(*arguments)

      scope   = arguments.slice!(0)
      options = arguments.slice!(0) || {}

      case scope
      when :all
        find_every(options)
      when :first
        collection = find_every(options)
        collection && collection.first
      when :last
        collection = find_every(options)
        collection && collection.last
      when :one
        find_one(options)
      else
        find_single(scope, options)
      end
    end # find

    def self.find_every(options)
      if Wistia.test?
        options.merge!( {params: {project_id: Wistia.test_project_id}} )
      end
      super
    end # find_every


    def self.find_one(options)
      case from = options[:from]
      when Symbol
        ad = instantiate_record(get(from, options[:params]))
      when String
        path = "#{from}#{query_string(options[:params])}"
        ad = instantiate_record(format.decode(connection.get(path, headers).body))
      end
      if Wistia.test?
        # check to see if the ad's project hashed id equals the Wistia.test_project_id
        if Wistia.test_project_id != ad.project.hashed_id
          # if the ad found is not in the Wistia.test_project_id then raise an error
          raise ActiveResource::ResourceNotFound.new(404, 'Ad not found in project!')
        end
      end

      return ad
    end

    # Overriding the find_single method so that we do not mess with things that are not part of test mode.
    def self.find_single(scope, options)
      prefix_options, query_options = split_options(options[:params])
      path = element_path(scope, prefix_options, query_options)
      ad = instantiate_record(format.decode(connection.get(path, headers).body), prefix_options)
      if Wistia.test?
        # check to see if the ad's project hashed id equals the Wistia.test_project_id
        if Wistia.test_project_id != ad.project.hashed_id
          # if the ad found is not in the Wistia.test_project_id then raise an error
          raise ActiveResource::ResourceNotFound.new(404, 'Ad not found in project!')
        end
      end
      return ad
    end

    def still(width = 640, options = {})
      options = {:format => 'jpg', :style => 'image_resize'}.merge(options)
      matcher = self.type == 'Image' ? /OriginalFile/ : /StillImage/
      self.assets.each do |asset|
        if asset.type.match(matcher)
          url = asset.url.gsub(/\.bin$/, ".#{options[:format]}?#{options[:style]}=#{width}")
          return url
        end
      end

      nil
    end

  end
end

module Wistia
  module Medias
    class Customization < Wistia::Base
      self.site = "#{Wistia::API_BASE_URL}medias/:media_hashed_id"
      self.collection_name = 'customizations'

      def self.find_by_media_id media_hashed_id
        url = "#{Wistia::API_BASE_URL}medias/#{media_hashed_id}/customizations.json"
        find :all, :from => url
      end

      def to_json(options = {})
        self.attributes.to_json(options)
      end

      def self.find_every(options)
        begin
          case from = options[:from]
          when Symbol
            instantiate_collection(get(from, options[:params]), options[:params])
          when String
            path = "#{from}#{query_string(options[:params])}"
            instantiate_collection([format.decode(connection.get(path, headers).body)] || [], options[:params])
          else
            prefix_options, query_options = split_options(options[:params])
            path = collection_path(prefix_options, query_options)
            instantiate_collection(([format.decode(connection.get(path, headers).body)] || []), query_options, prefix_options)
          end
        rescue ActiveResource::ResourceNotFound
          # Swallowing ResourceNotFound exceptions and return nil - as per
          # ActiveRecord.
          nil
        end
      end

      
    end
  end
end
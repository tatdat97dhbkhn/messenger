module Giphy
  module Gifs
    class SearchService < Giphy::BaseService
      parameters :options
      attr_reader :gifs

      def call
        response = connection.get("gifs/search") do |req|
          req.params = {
            api_key: Rails.application.credentials.dig(:giphy_api_key),
            q: options[:q]
          }
        end

        @gifs = response.body['data'] || []
      end
    end
  end
end

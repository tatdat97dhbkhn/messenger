module Giphy
  module Gifs
    class TrendingService < Giphy::BaseService
      parameters :options
      attr_reader :gifs

      def call
        response = connection.get("gifs/trending") do |req|
          req.params = {
            api_key: Rails.application.credentials.dig(:giphy_api_key),
          }
        end

        @gifs = response.body['data'] || []
      end
    end
  end
end

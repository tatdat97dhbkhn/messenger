# frozen_string_literal: true

module Giphy
  module Gifs
    # This is your giphy/gifs/trending service
    class TrendingService < Giphy::BaseService
      parameters :options
      attr_reader :gifs

      def call
        response = connection.get('gifs/trending') do |req|
          req.params = {
            api_key: Rails.application.credentials[:giphy_api_key]
          }
        end

        @gifs = response.body['data'] || []
      end
    end
  end
end

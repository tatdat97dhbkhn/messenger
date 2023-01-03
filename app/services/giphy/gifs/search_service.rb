# frozen_string_literal: true

module Giphy
  module Gifs
    # This is your giphy/gifs/search service
    class SearchService < Giphy::BaseService
      parameters :options
      attr_reader :gifs

      def call
        response = connection.get('gifs/search') do |req|
          req.params = {
            api_key: Rails.application.credentials[:giphy_api_key],
            q: options[:q]
          }
        end

        @gifs = response.body['data'] || []
      end
    end
  end
end

# frozen_string_literal: true

module Giphy
  # This is your giphy/base service
  class BaseService < ApplicationService
    API_DOMAIN = 'https://api.giphy.com'
    API_VERSION = 'v1'

    def connection(headers: {})
      Faraday.new(url: api_url, headers:) do |faraday|
        faraday.request  :url_encoded
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
    end

    private

    def api_url
      "#{API_DOMAIN}/#{API_VERSION}"
    end
  end
end

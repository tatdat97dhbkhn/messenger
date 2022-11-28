module Giphy
  class BaseService < ApplicationService
    API_DOMAIN = 'https://api.giphy.com'.freeze
    API_VERSION = 'v1'.freeze

    def connection(headers: {})
      Faraday.new(url: api_url, headers: headers) do |faraday|
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

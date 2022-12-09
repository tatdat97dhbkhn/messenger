module Channels
  class FilterService < ApplicationService
    parameters :params, :channels
    attr_reader :channels

    def call
      @channels = if params[:filter].present?
                    channels.filter_records(params[:filter].slice(:name_cont))
                  else
                    channels
                  end
    end
  end
end

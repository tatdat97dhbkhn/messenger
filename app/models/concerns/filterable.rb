# frozen_string_literal: true

# This is your filterable model concern
module Filterable
  extend ActiveSupport::Concern

  # This is your class methods of Filterable concern
  module ClassMethods
    def filter_records(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end

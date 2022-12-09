module Users
  class FilterService < ApplicationService
    parameters :params, :users
    attr_reader :users

    def call
      @users = if params[:filter].present?
                 users.filter_records(params[:filter].slice({}))
               else
                 users
               end
    end
  end
end

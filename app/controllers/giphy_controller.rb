# frozen_string_literal: true

# This is your giphy controller
class GiphyController < ApplicationController
  def index
    @gifs = if params[:q].present?
              Giphy::Gifs::SearchService.call(options: { q: params[:q].to_s.strip })
            else
              Giphy::Gifs::TrendingService.call
            end.gifs
  end
end

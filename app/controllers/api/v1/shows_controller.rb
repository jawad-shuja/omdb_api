# frozen_string_literal: true

# app/controllers/api/v1/shows_controller.rb

module Api
  module V1
    # API Shows Controller
    class ShowsController < Api::V1::BaseController
      before_action :set_movie, only: %w[index]

      def index
        shows = @movie.shows.upcoming
        render_collection(shows, ShowBlueprint)
      end

      private

      def set_movie
        @movie = Movie.find(params[:movie_id])
      end
    end
  end
end

# frozen_string_literal: true

# app/controllers/api/v1/movies_controller.rb

module Api
  module V1
    # API Movies Controller
    class MoviesController < Api::V1::BaseController
      before_action :set_movie, only: %w[show update show_times]

      def index
        movies = Movie.includes(:movie_datum)
        movies_with_data = movies.map(&:fetch_details_from_omdb)
        render_collection(movies_with_data, MovieBlueprint)
      end

      def show
        movie_with_data = @movie.fetch_details_from_omdb
        render_response(movie_with_data, MovieBlueprint)
      end

      def update
        authorize @movie
        if @movie.update(movie_params)
          movie_with_data = @movie.fetch_details_from_omdb
          render_response(movie_with_data, MovieBlueprint)
        else
          raise ActiveRecord::RecordInvalid, @movie
        end
      end

      private

      def set_movie
        @movie = Movie.find(params[:id])
      end

      def movie_params
        params.require(:movie).permit(:price, shows_attributes: %i[id show_time _destroy])
      end
    end
  end
end

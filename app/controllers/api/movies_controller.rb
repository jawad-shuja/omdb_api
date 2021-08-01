# app/controllers/api/movies_controller.rb

class Api::MoviesController < Api::BaseController

  before_action :set_movie, only: %w[show]

  def index
    movies = Movie.includes(:movie_datum)
    movies_with_data = movies.map {|movie| movie.fetch_details_from_omdb }
    render_collection(movies_with_data, MovieBlueprint)
  end

  def show
    movie_with_data = @movie.fetch_details_from_omdb
    render_response(movie_with_data, MovieBlueprint)
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

end

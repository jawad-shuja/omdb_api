# app/controllers/api/movies_controller.rb

class Api::MoviesController < Api::BaseController

  before_action :set_movie, only: %w[show update show_times]

  def index
    movies = Movie.includes(:movie_datum)
    movies_with_data = movies.map {|movie| movie.fetch_details_from_omdb }
    render_collection(movies_with_data, MovieBlueprint)
  end

  def show
    movie_with_data = @movie.fetch_details_from_omdb
    render_response(movie_with_data, MovieBlueprint)
  end

  def update
    unless @movie.update(movie_params)
      raise ActiveRecord::RecordInvalid, @movie
    else
      movie_with_data = @movie.fetch_details_from_omdb
      render_response(movie_with_data, MovieBlueprint)
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:price, shows_attributes: [:id, :show_time, :_destroy])
  end

end

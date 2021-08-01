# app/controllers/api/v1/shows_controller.rb

class Api::V1::ShowsController < Api::V1::BaseController

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

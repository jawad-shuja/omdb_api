# app/controllers/api/movies_controller.rb

class Api::MoviesController < Api::BaseController

  before_action :set_movie, only: %w[show]

  def show
    render_response(@movie, MovieBlueprint)
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

end

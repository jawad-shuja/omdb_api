# app/controllers/api/v1/reviews_controller.rb

class Api::V1::ReviewsController < Api::V1::BaseController

  before_action :set_movie, only: %w[create]

  def create
    review = @movie.reviews.build(review_params)
    review.user = current_user

    unless review.save!
      raise ActiveRecord::RecordInvalid, review
    else
      render_response(review, ReviewBlueprint)
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:rating)
  end

end

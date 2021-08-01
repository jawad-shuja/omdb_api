# frozen_string_literal: true

# app/controllers/api/v1/reviews_controller.rb

module Api
  module V1
    # API Reviews Controller
    class ReviewsController < Api::V1::BaseController
      before_action :set_movie, only: %w[create]

      def create
        review = @movie.reviews.build(review_params)
        review.user = current_user

        if review.save!
          render_response(review, ReviewBlueprint)
        else
          raise ActiveRecord::RecordInvalid, review
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
  end
end

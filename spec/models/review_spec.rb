# spec/models/review_spec.rb

require 'rails_helper'

describe Review, type: :model do
  context 'validations' do
    let! (:user) { create_user }
    let! (:movie) { create_movie }

    it "is valid with rating from 1 to 5" do
      review = Review.new(rating: 3, movie: movie, user: user)
      expect(review).to be_valid
    end

    it "is not valid with out of bounds rating" do
      review = Review.new(rating: 6, movie: movie, user: user)
      expect(review).to_not be_valid
    end
  end
end

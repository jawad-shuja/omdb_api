# frozen_string_literal: true

# spec/controllers/api/reviews_controller_spec.rb

require 'rails_helper'

describe Api::V1::ReviewsController, type: :request do
  let(:user) { create_user }
  let(:movie) { create_movie }

  context 'When creating review' do
    before do
      login_with_api(user)

      post "/api/movies/#{movie.id}/reviews", headers: {
        'Authorization': response.headers['Authorization']
      }, params: {
        review: {
          rating: 4
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the review' do
      expect(json).to include('rating' => 4)
    end
  end

  context 'When creating review rating greating than 5 (Maximum)' do
    before do
      login_with_api(user)

      post "/api/movies/#{movie.id}/reviews", headers: {
        'Authorization': response.headers['Authorization']
      }, params: {
        review: {
          rating: 40
        }
      }
    end

    it 'returns 422' do
      expect(response.status).to eq(422)
    end
  end
end

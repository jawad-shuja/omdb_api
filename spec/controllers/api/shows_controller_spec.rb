# frozen_string_literal: true

# spec/controllers/api/shows_controller_spec.rb

require 'rails_helper'

describe Api::V1::ShowsController, type: :request do
  let(:user) { create_user }
  let(:movie) { create_movie }

  context 'When fetching movie shows' do
    before do
      login_with_api(user)
      create_show_for_movie(movie)
      create_show_for_movie(movie)

      get "/api/movies/#{movie.id}/shows", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns all of the movie shows' do
      expect(json).to be_an_instance_of(Array)
      expect(json.length).to be(2)
    end
  end

  context 'When fetching shows for movies with old show' do
    before do
      login_with_api(user)
      create_old_show_for_movie(movie)
      create_show_for_movie(movie)

      get "/api/movies/#{movie.id}/shows", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns all upcoming shows of the movie' do
      expect(json).to be_an_instance_of(Array)
      expect(json.length).to be(1)
    end
  end
end

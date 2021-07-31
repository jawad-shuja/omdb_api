# spec/controllers/api/movies_controller_spec.rb

require 'rails_helper'

describe Api::MoviesController, type: :request do

  let (:user) { create_user }
  let! (:movie) { create_movie }

  context 'When fetching a movie' do
    before do
      login_with_api(user)
      get "/api/movies/#{movie.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the movie' do
      expect(json).to include("id" => movie.id)
    end
  end

  context 'When a movie is missing' do
    before do
      login_with_api(user)
      get '/api/movies/blank', headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/api/movies/#{movie.id}"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end

  context 'When fetching movies' do
    before do
      login_with_api(user)
      get '/api/movies', headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns one of the movie' do
      expect(json).to be_an_instance_of(Array)
      expect(json).to include({ 'id' => movie.id, 'omdb_reference' => movie.omdb_reference })
    end
  end

end

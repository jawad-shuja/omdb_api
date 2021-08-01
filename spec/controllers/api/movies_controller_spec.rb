# spec/controllers/api/movies_controller_spec.rb

require 'rails_helper'

describe Api::V1::MoviesController, type: :request do

  let (:user) { create_user }
  let (:admin) { create_admin }
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
      expect(json.any? { |movie| movie['title'] == "The Fast and the Furious" }).to be true
    end
  end

  context 'When updating movie shows as customer' do
    before do
      login_with_api(user)
      patch "/api/movies/#{movie.id}", headers: {
        'Authorization': response.headers['Authorization']
      }, params: {
        movie: {
          shows_attributes: [
            {
              show_time: "01-08-2021 03:06:14 AM"
            }
          ]
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401 )
    end
  end

  context 'When updating movie shows as admin' do
    before do
      login_with_api(admin)
      patch "/api/movies/#{movie.id}", headers: {
        'Authorization': response.headers['Authorization']
      }, params: {
        movie: {
          shows_attributes: [
            {
              show_time: "01-08-2021 03:06:14 AM"
            }
          ]
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'return movie with show time' do
      expect(json).to include("id" => movie.id)
      expect(movie.shows.count).to be(1)
    end
  end

  context 'When updating movie shows as admin with some missing data' do
    before do
      login_with_api(admin)
      patch "/api/movies/#{movie.id}", headers: {
        'Authorization': response.headers['Authorization']
      }, params: {
        movie: {
          shows_attributes: [
            {
              incorrect_field: "01-08-2021 03:06:14 AM"
            },
            {
              incorrect_field: "02-08-2021 03:06:14 AM"
            },
            {
              show_time: "01-08-2021 03:06:14 AM"
            }
          ]
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'silently skip incorrect field and adds correct field' do
      expect(json).to include("id" => movie.id)
      expect(movie.shows.count).to be(1)
    end
  end
end

# spec/models/movie_spec.rb

require 'rails_helper'

describe Movie, type: :model do
  context 'validations' do
    it 'is valid with positive price' do
      movie = Movie.new(price: 10)
      expect(movie).to be_valid
    end

    it 'is not valid with negative price' do
      movie = Movie.new(price: -10)
      expect(movie).to_not be_valid
    end
  end

  context 'fetch_details_from_omdb' do
    let!(:movie) { create_movie }
    it 'fetches data and assigns to attribuets' do
      expect(movie.fetch_details_from_omdb.Title).to eq('The Fast and the Furious')
    end
  end
end

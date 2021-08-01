# frozen_string_literal: true

# app/blueprints/movie_blueprint.rb

class MovieBlueprint < Blueprinter::Base
  identifier :id

  fields :price, :imdbRating, :imdbVotes, :imdbID

  field :Title, name: :title
  field :Year, name: :year
  field :Rated, name: :rated
  field :Released, name: :released
  field :Runtime, name: :runtime
  field :Genre, name: :genre
  field :Director, name: :director
  field :Writer, name: :writer
  field :Actors, name: :actors
  field :Plot, name: :plot
  field :Language, name: :language
  field :Country, name: :country
  field :Awards, name: :awards
  field :Poster, name: :poster
  field :Ratings, name: :ratings
  field :Metascore, name: :metascore
  field :Type, name: :type
  field :DVD, name: :dvd
  field :BoxOffice, name: :boxOffice
  field :Production, name: :production
  field :Website, name: :website

  association :shows, blueprint: ShowBlueprint do |user, _options|
    user.shows.upcoming
  end

  association :reviews, blueprint: ReviewBlueprint
end

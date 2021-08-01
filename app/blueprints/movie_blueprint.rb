class MovieBlueprint < Blueprinter::Base
  identifier :id

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
  field :imdbRating
  field :imdbVotes
  field :imdbID
  field :Type, name: :type
  field :DVD, name: :dvd
  field :BoxOffice, name: :boxOffice
  field :Production, name: :production
  field :Website, name: :website
end

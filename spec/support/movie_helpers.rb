# spec/support/movie_helpers.rb

require 'factory_bot_rails'

module MovieHelpers

  def create_movie
    FactoryBot.create(
      :movie,
      omdb_reference: "tt0322259",
    )
  end

  def build_movie
    FactoryBot.build(
      :movie,
      omdb_reference: "tt0322259",
    )
  end

end

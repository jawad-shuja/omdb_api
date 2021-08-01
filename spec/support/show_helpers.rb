# frozen_string_literal: true

# spec/support/show_helpers.rb

require 'faker'
require 'factory_bot_rails'

module ShowHelpers
  def create_show_for_movie(movie)
    FactoryBot.create(
      :show,
      show_time: Faker::Time.between(from: DateTime.now + 1.day, to: DateTime.now + 7.days),
      movie_id: movie.id
    )
  end

  def create_old_show_for_movie(movie)
    FactoryBot.create(
      :show,
      show_time: Faker::Time.between(from: DateTime.now - 7.days, to: DateTime.now - 1.day),
      movie_id: movie.id
    )
  end
end

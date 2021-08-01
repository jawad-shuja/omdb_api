# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

User.create!(email: 'test@example.com', password: 'Password!1', role: User.roles[:admin])

omdb_ids = %w[tt0232500 tt0322259 tt0463985 tt1013752 tt1596343 tt1905041 tt2820852 tt4630562]
omdb_ids.each do |movie_id|
  Movie.create!(omdb_reference: movie_id)
end

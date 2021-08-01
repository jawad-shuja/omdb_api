# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies, id: :uuid do |t|
      t.string :omdb_reference

      t.timestamps
    end
  end
end

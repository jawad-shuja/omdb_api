# frozen_string_literal: true

class CreateMovieData < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_data, id: :uuid do |t|
      t.json :ombd_meta
      t.datetime :last_modified_at
      t.references :movie, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateShows < ActiveRecord::Migration[6.1]
  def change
    create_table :shows, id: :uuid do |t|
      t.datetime :show_time
      t.references :movie, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddPriceToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :price, :float
  end
end

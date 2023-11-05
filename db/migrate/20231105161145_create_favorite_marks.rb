# frozen_string_literal: true

class CreateFavoriteMarks < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_marks do |t|
      t.references :user, index: true
      t.references :recipe, index: true
    end
  end
end

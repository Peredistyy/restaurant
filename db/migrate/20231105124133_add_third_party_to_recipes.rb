# frozen_string_literal: true

class AddThirdPartyToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :third_party_id, :integer, index: true
    add_column :recipes, :third_party_provider_name, :string, index: true
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeShortSerializer do
  let(:recipe) { create(:recipe) }
  let(:serialized_data) do
    {
      data: {
        attributes: {
          name: recipe.name
        },
        id: recipe.id.to_s,
        type: :recipe_short
      }
    }
  end

  it 'serializable_hash' do
    expect(described_class.new(recipe).serializable_hash).to eq(serialized_data)
  end
end
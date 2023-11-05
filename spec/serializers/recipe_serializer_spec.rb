# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeSerializer do
  let(:recipe) { create(:recipe) }
  let(:serialized_data) do
    {
      data: {
        attributes: {
          image_url: recipe.image_url,
          instructions: recipe.instructions,
          name: recipe.name,
          favorite: false
        },
        id: recipe.id.to_s,
        type: :recipe
      }
    }
  end

  it 'serializable_hash' do
    expect(described_class.new(recipe).serializable_hash).to eq(serialized_data)
  end
end
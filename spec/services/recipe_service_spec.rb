# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeService do
  describe 'random' do
    let(:response_body) { File.read(Rails.root.join('spec', 'fixtures', 'random.json')) }

    before do
      stub_request(:get, "https://www.themealdb.com/api/json/v1/1/random.php")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => "Faraday v#{Faraday::VERSION}"
          })
        .to_return(
          status: 200,
          body: response_body,
          headers: {}
        )
    end

    it 'success' do
      recipe = described_class.new.random

      expect(recipe).to be_a Recipe
      expect(recipe.name).to eq('Honey Teriyaki Salmon')
      expect(recipe.instructions).to eq(
        "Mix all the ingredients in the Honey Teriyaki Glaze together. Whisk to blend well. Combine the salmon and the Glaze together.\r\n" +
        "\r\n" +
        "Heat up a skillet on medium-low heat. Add the oil, Pan-fry the salmon on both sides until it’s completely cooked inside and the glaze thickens.\r\n" +
        "\r\n" +
        "Garnish with sesame and serve immediately."
      )
      expect(recipe.image_url).to eq('https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg')
    end

    it 'success with already exists entity' do
      recipe = create(:recipe, third_party_id: '52773')

      expect(described_class.new.random).to eq(recipe)
    end
  end
end
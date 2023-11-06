require 'feature_helper'

feature 'RecipesController', type: :api do
  let(:recipe) { create(:recipe) }
  let(:user) { create(:user) }
  let(:response_body) { File.read(Rails.root.join('spec', 'fixtures', 'random.json')) }

  before do
    login_as(user)
  end

  describe 'index' do
    let(:recipe1) { create(:recipe) }
    let(:recipe2) { create(:recipe) }

    let(:expected_data) do
      {
        'data' => [
          {
            'attributes' => {
              'name' => recipe2.name
            },
            'id' => recipe2.id.to_s,
            'type' => 'recipe_short'
          }
        ]
      }
    end

    it 'success' do
      recipe1
      recipe2.favorite_marks.create(user: user)

      page.driver.get('/recipes')

      expect(page.status_code).to eq(200)
      expect(json).to eq(expected_data)
    end
  end

  describe 'show' do
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

    let(:expected_data) do
      {
        'data' => {
          'attributes' => {
            'image_url' => expected_recipe.image_url,
            'instructions' => expected_recipe.instructions,
            'name' => expected_recipe.name,
            'favorite' => false
          },
          'id' => expected_recipe.id.to_s,
          'type' => 'recipe'
        }
      }
    end

    describe 'success with random' do
      let(:expected_recipe) { Recipe.last }

      it 'success' do
        page.driver.get('/recipes/0')

        expect(page.status_code).to eq(200)
        expect(json).to eq(expected_data)
      end
    end

    describe 'success by id' do
      let(:expected_recipe) { recipe }

      it 'success' do
        page.driver.get("/recipes/#{recipe.id}")

        expect(page.status_code).to eq(200)
        expect(json).to eq(expected_data)
      end
    end
  end

  describe 'update' do
    describe 'favorite = true' do
      it 'success' do
        page.driver.put("/recipes/#{recipe.id}", {favorite: true})

        expect(page.status_code).to eq(200)
        recipe.reload
        expect(recipe.favorite_by_user?(user)).to eq(true)
        expect(json['data']['attributes']['favorite']).to eq(true)
      end
    end

    describe 'favorite = false' do
      it 'success' do
        recipe.favorite_marks.create(user: user)

        page.driver.put("/recipes/#{recipe.id}", {favorite: false})

        expect(page.status_code).to eq(200)
        recipe.reload
        expect(recipe.favorite_by_user?(user)).to eq(false)
        expect(json['data']['attributes']['favorite']).to eq(false)
      end
    end
  end
end
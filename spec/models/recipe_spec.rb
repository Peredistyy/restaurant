require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }

  describe '#validate' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:instructions) }
    it { should validate_presence_of(:image_url) }
  end

  describe 'active record associations' do
    it { is_expected.to have_many(:favorite_marks) }
  end

  describe 'only_favorite_by' do
    let(:recipe1) { create(:recipe) }
    let(:recipe2) { create(:recipe) }

    it 'success' do
      recipe1
      recipe2.favorite_marks.create(user: user)

      expect(described_class.only_favorite_by(user)).to eq([recipe2])
    end
  end

  describe 'favorite_by_user?' do
    it 'success (true)' do
      recipe.favorite_marks.create(user: user)

      expect(recipe.favorite_by_user?(user)).to eq(true)
    end

    it 'success (false)' do
      expect(recipe.favorite_by_user?(user)).to eq(false)
    end
  end

  describe 'mark_as_favorite' do
    it 'success (true)' do
      recipe.mark_as_favorite(user)

      expect(recipe.favorite_marks.exists?(user: user)).to eq(true)
    end

    it 'success (false)' do
      expect(recipe.favorite_marks.exists?(user: user)).to eq(false)
    end
  end

  describe 'unmark_as_favorite' do
    it 'success (false)' do
      recipe.favorite_marks.create(user: user)
      recipe.unmark_as_favorite(user)

      expect(recipe.favorite_marks.exists?(user: user)).to eq(false)
    end
  end
end
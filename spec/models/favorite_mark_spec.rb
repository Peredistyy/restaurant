require 'rails_helper'

RSpec.describe FavoriteMark, type: :model do
  describe "active record associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:recipe) }
  end
end
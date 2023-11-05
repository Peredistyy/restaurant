class RecipeService
  def random
    meal = (provider.random['meals'] || []).first

    Recipe.find_or_create_by(third_party_id: meal['idMeal'], third_party_provider_name: 'themealdb') do |entity|
      entity.name = meal['strMeal']
      entity.instructions = meal['strInstructions']
      entity.image_url = meal['strMealThumb']
    end
  end

  private

  def provider
    @provider ||= ThemealdbService.new
  end
end
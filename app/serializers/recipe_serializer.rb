class RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :instructions, :image_url

  attributes :favorite do |object, params|
    params[:current_user] ? object.favorite_by_user?(params[:current_user]) : false
  end
end
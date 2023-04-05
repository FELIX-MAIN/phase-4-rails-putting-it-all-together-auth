class RecipesController < ApplicationController
    before_action :require_login, only: [:create]
  
    def index
      if logged_in?
        recipes = Recipe.all.includes(:user)
        render json: recipes.as_json(include: { user: { only: [:id, :username, :image_url, :bio] } }, only: [:id, :title, :instructions, :minutes_to_complete]), status: :ok
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    def create
      recipe = current_user.recipes.build(recipe_params)
      if recipe.save
        render json: recipe.as_json(include: { user: { only: [:id, :username, :image_url, :bio] } }, only: [:id, :title, :instructions, :minutes_to_complete]), status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def recipe_params
      params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
  end
  
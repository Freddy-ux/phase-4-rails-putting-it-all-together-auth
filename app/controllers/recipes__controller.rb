class RecipesController < ApplicationController
    def create
      if current_user
        recipe = current_user.recipes.new(recipe_params)
        if recipe.save
          render json: recipe_info(recipe), status: :created
        else
          render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def recipe_params
      params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
  
    def recipe_info(recipe)
      {
        title: recipe.title,
        instructions: recipe.instructions,
        minutes_to_complete: recipe.minutes_to_complete,
        user: user_info(recipe.user)
      }
    end
  
    def user_info(user)
      {
        id: user.id,
        username: user.username,
        image_url: user.image_url,
        bio: user.bio
      }
    end
  end
  
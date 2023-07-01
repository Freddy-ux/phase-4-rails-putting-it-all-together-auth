class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user_info(user), status: :ok
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def user_info(user)
      {
        id: user.id,
        username: user.username,
        image_url: user.image_url,
        bio: user.bio
      }
    end
  end
  
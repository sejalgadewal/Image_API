class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

#   def index
#     @users = User.all.joins(:avatar_attachment)
#     render json: @users.map { |user| 
#        user.as_json(only: %i[name]).merge(
#        avatar_path: url_for(user.avatar)) }  
       
#  end 
 def index 
  users = User.all 
  render json: users.map{ |user| 
                if user.avatar.attached? 
                  user.as_json(only: :name).merge(
                       avatar_path: url_for(user.avatar))
                else 
                   user.as_json only: :name
                end
              }
end 
def show
   user = User.find(params[:id])
    if user.avatar.attached? 
      render json: user.as_json(only: %i[name]).merge(
                  avatar_path: url_for(user.avatar))
    else 
     user.as_json only: :name
   end 
end 

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:avatar)
    end
end

class UsersController < ApplicationController
  before_action :authenticate, only: [:update, :destroy]

  def show
    user = find_user(params[:id])
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource
                           .new(user, include: ["posts", "comments", "posts.user", "posts.tags", "comments.user"])
    }, status: :ok if user
  end

  def showSimple
    if user_signed_in?
      render json: { status: "success", data: current_user }, status: :ok
    else
      render json: { status: "error", message: "User Not Signed In" }, status: :unauthorized
    end
  end

  def update
    user = find_user(params[:id])
    return unless user

    if user.update(user_update_params)
      render json: { status: "success",
                     data: ActiveModelSerializers::SerializableResource
                             .new(user, include: ["username", "image", "bio"])
      }, status: :ok
    else
      render json: { status: "error", message: user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    user = find_user(params[:id])
    return unless user

    atr = {
      image: "[deleted]",
      bio: "[deleted]",
      email: "[deleted]@gmail.com",
      encrypted_password: "[deleted]"
    }
    user.update!(atr)
    user.update_attribute(:username, "[deleted]")
    render json: { status: "success", data: user }, status: :ok
  end

  private
  def user_update_params
    params.require(:user).permit(:image, :bio)
  end

  def authenticate
    unless user_signed_in?
      render json: { status: "error", message: "You must be signed in!" }
    end
  end

  def find_user(id)
    begin
      user = User.find(id)
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "User Not Found" }, status: :not_found and return
    end
    user
  end
end

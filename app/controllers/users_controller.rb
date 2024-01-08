#noinspection RubyResolve
class UsersController < ApplicationController
  before_action :authenticate, only: [:update, :destroy]
  before_action except: [:showSimple] do
    find_user(params[:id])
  end
  before_action :check_correct_user, only: [:update, :destroy]

    def show
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource
                           .new(@user, include: %w[posts comments posts.user posts.tags comments.user])
    }, status: :ok
  end

  def showSimple
    if user_signed_in?
      render json: { status: "success", data: current_user }, status: :ok
    else
      render json: { status: "error", message: "User Not Signed In" }, status: :unauthorized
    end
  end

  def update
    if @user.update(user_update_params)
      render json: { status: "success",
                     data: ActiveModelSerializers::SerializableResource
                             .new(@user, include: %w[username image bio])
      }, status: :ok
    else
      render json: { status: "error", message: @user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @user.destroy
    render json: { status: "success", data: {} }, status: :ok
  end

  private
  def authenticate
    unless user_signed_in?
      render json: { status: "error", message: "You must be signed in!" }
    end
  end

  def check_correct_user
    if @user[:id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naughty! Don't touch other people's accounts!" }
    end
  end

  def find_user(id)
    begin
      @user = User.find(id)
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "User Not Found" }, status: :not_found and return
    end
    @user
  end

  def user_update_params
    params.require(:user).permit(:image, :bio)
  end
end

class PostsController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy, :like, :dislike]
  def index
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource
                           .new(Post.all, include: ["user", "tags"], current_user: current_user) }, status: :ok
  end
  def show
    post = find_post(params[:id])
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource
                           .new(post, current_user: current_user)
    }, status: :ok if post
  end

  def create
    begin
      post = Post.create(post_create_params)
      post[:user_id] = current_user[:id]
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "Tags Not Found" }, status: :bad_request and return
    end

    if post.save
      render json: { status: "success",
                     data: ActiveModelSerializers::SerializableResource.new(post, current_user: current_user)
      }, status: :created
    else
      render json: { status: "error", message: post.errors.full_messages }, status: :bad_request
    end
  end

  def update
    post = find_post(params[:id])
    return unless post

    if post[:user_id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naught! Don't update other people posts!" }
      return
    end

    if post[:deleted]
      render json: { status: "error", message: "Can't update deleted posts!" }
      return
    end

    begin
      # filling in missing params
      post_update_params[:user_id] = post[:user_id]

      post.update!(post_update_params)
    rescue ActionController::ParameterMissing
      render json: { status: "error", message: post.errors.full_messages }, status: :bad_request and return
    rescue ActiveRecord::RecordInvalid
      render json: { status: "error", message: post.errors.full_messages }, status: :bad_request and return
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "Tags Not Found" }, status: :bad_request and return
    end

    render json: { status: "success", data: post }, status: :ok
  end

  def destroy
    post = find_post(params[:id])
    return unless post

    if post[:user_id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naught! Don't delete other people posts!" }, status: :unauthorized
      return
    end

    # This does not delete the comments of the post
    # This behaviour is intentional

    PostTag.where(post_id: post[:id]).destroy_all
    post.update_attribute(:title, "[deleted]")
    post.update_attribute(:body, "[deleted]")
    post.update_attribute(:deleted, true)
    render json: { status: "success", data: post }, status: :ok
  end

  def like
    post = find_post(params[:id])
    return unless post

    like = PostsLike.find_by(user_id: current_user[:id], post_id: params[:id])

    if like
      like.destroy
    else
      PostsDislike.find_by(user_id: current_user[:id], post_id: params[:id]).try(:destroy)
      PostsLike.create(user_id: current_user[:id], post_id: params[:id])
    end
  end

  def dislike
    post = find_post(params[:id])
    return unless post

    dislike = PostsDislike.find_by(user_id: current_user[:id], post_id: params[:id])

    if dislike
      dislike.destroy
    else
      PostsLike.find_by(user_id: current_user[:id], post_id: params[:id]).try(:destroy)
      PostsDislike.create(user_id: current_user[:id], post_id: params[:id])
    end
  end

  private
  def post_create_params
    params.require(:post).permit(:title, :body, :image, tag_ids: [])
  end

  def post_update_params
    params.require(:post).permit(:title, :body, :image, tag_ids: [])
  end

  def authenticate
    unless user_signed_in?
      render json: { status: "error", message: "You must be signed in!" }
    end
  end

  def find_post(id)
    begin
      post = Post.find(id)
    rescue ActiveRecord::ActiveRecordError
      render json: { status: "error", message: "Post Not Found" }, status: :not_found and return
    end
    post
  end
end

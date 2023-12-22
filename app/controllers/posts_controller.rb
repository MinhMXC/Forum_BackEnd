class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  def index
    render json: { status: "success", data: ActiveModelSerializers::SerializableResource.new(Post.all, include: ['user', 'tags']) }, status: :ok
  end
  def show
    post = find_post(params[:id])
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource.new(post)
    }, status: :ok if post
  end

  def create
    begin
      post = Post.create(post_create_params)
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "Tags Not Found" }, status: :bad_request and return
    end

    if post.save
      render json: { status: "success",
                     data: ActiveModelSerializers::SerializableResource.new(post)
      }, status: :created
    else
      render json: { status: "error", message: post.errors.full_messages }, status: :bad_request
    end
  end

  def update
    post = find_post(params[:id])
    return unless post

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

    # This does not delete the comments of the post
    # This behaviour is intentional

    PostTag.where(post_id: post[:id]).destroy_all
    post.update_attribute(:title, "[deleted]")
    post.update_attribute(:body, "[deleted]")
    render json: { status: "success", data: post }, status: :ok
  end



  private
  def post_create_params
    params.require(:post).permit(:title, :body, :image, :user_id, tag_ids: [])
  end

  def post_update_params
    params.require(:post).permit(:title, :body, :image, tag_ids: [])
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

#noinspection RubyResolve
class PostsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action except: [:index, :create] do
    find_post(params[:id])
  end
  before_action :check_correct_user, only: [:update, :destroy]

  def index
    if params[:advanced] == nil
      posts = Post.all
    elsif params[:advanced] == "true"
      posts = Post.where("title ILIKE ? AND body ILIKE ?", "%#{params[:title]}%", "%#{params[:body]}%")

      unless params[:tags].blank?
        tags = params[:tags].split(/,/, -1)
        posts = posts.joins(:tags)
                     .where(:tags => { tag_text: [tags] })
                     .having("count(tags.id) = ?", tags.count).group("posts.id")
      end
    else
      posts = Post.where("(title||body) ILIKE ?", "%#{params[:search]}%")
    end

    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource
                           .new(posts, include: %w[user tags visited], current_user: current_user) }, status: :ok
  end
  def show
    if current_user
      unless Viewed.find_by(user_id: current_user[:id], post_id: params[:id])
        Viewed.create(user_id: current_user[:id], post_id: params[:id])
      end
    end

    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource
                           .new(@post, current_user: current_user)
    }, status: :ok
  end

  def create
    begin
      post = Post.create(post_create_params)
      post[:body] = post[:body].strip
      post[:user_id] = current_user[:id]
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "Tags Not Found" }, status: :bad_request
      return
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
    begin
      # filling in missing params
      post_update_params[:user_id] = @post[:user_id]
      @post.update!(post_update_params)
    rescue ActionController::ParameterMissing
      render json: { status: "error", message: @post.errors.full_messages }, status: :bad_request
      returm
    rescue ActiveRecord::RecordInvalid
      render json: { status: "error", message: @post.errors.full_messages }, status: :bad_request
      return
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "Tags Not Found" }, status: :bad_request
      return
    end

    render json: { status: "success", data: @post }, status: :ok
  end

  def destroy
    # This does not delete the comments of the post
    # This behaviour is intentional

    PostTag.where(post_id: @post[:id]).destroy_all
    @post.update_attribute(:title, "[deleted]")
    @post.update_attribute(:body, "[deleted]")
    @post.update_attribute(:image, nil)
    @post.update_attribute(:user_id, nil)
    render json: { status: "success", data: @post }, status: :ok
  end

  def like
    like = PostsLike.find_by(user_id: current_user[:id], post_id: @post[:id])

    if like
      like.destroy
    else
      PostsDislike.find_by(user_id: current_user[:id], post_id: @post[:id]).try(:destroy)
      PostsLike.create(user_id: current_user[:id], post_id: @post[:id])
    end
  end

  def dislike
    dislike = PostsDislike.find_by(user_id: current_user[:id], post_id: @post[:id])

    if dislike
      dislike.destroy
    else
      PostsLike.find_by(user_id: current_user[:id], post_id: @post[:id]).try(:destroy)
      PostsDislike.create(user_id: current_user[:id], post_id: @post[:id])
    end
  end

  private
  def authenticate
    unless user_signed_in?
      render json: { status: "error", message: "You must be signed in!" }
    end
  end

  def find_post(id)
    begin
      @post = Post.find(id)
    rescue ActiveRecord::ActiveRecordError
      render json: { status: "error", message: "Post Not Found" }, status: :not_found
      return
    end
    @post
  end

  def check_correct_user
    if @post[:user_id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naughty! Don't touch other people's posts!" }
    end
  end

  def post_create_params
    params.require(:post).permit(:title, :body, :image, tag_ids: [])
  end

  def post_update_params
    params.require(:post).permit(:title, :body, :image, tag_ids: [])
  end
end

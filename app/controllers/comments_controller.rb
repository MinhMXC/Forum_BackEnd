#noinspection RubyResolve
class CommentsController < ApplicationController
  before_action :authenticate, except: [:show]
  before_action except: [:create] do
    find_comment(params[:id])
  end
  before_action :check_correct_user, only: [:update, :destroy]

  def show
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource.new(@comment, current_user: current_user)
    }, status: :ok
  end

  def create
    #sanitising input
    comment_create_params[:body] = Sanitize.clean(comment_create_params[:body].strip)

    comment = Comment.new(comment_create_params)

    # filling in missing params
    comment[:user_id] = current_user[:id]

    post = Post.find(comment[:post_id])
    if post[:title] == "[deleted]"
      render json: { status: "error", message: "Can't reply to deleted posts!" }, status: :bad_request
      return
    end

    if comment[:comment_id] != nil
      comment_parent = Comment.find_by_id(comment[:comment_id])
      if comment_parent
        if comment_parent[:body] == "[deleted]"
          render json: { status: "error", message: "Can't reply to deleted comments!" }, status: :bad_request
          return
        end
      else
        render json: { status: "error", message: comment_parent.errors.full_messages }, status: :bad_request
        return
      end
    end

    if comment.save
      render json: { status: "success", data: ActiveModelSerializers::SerializableResource.new(comment, current_user: current_user) }, status: :created
    else
      render json: { status: "error", message: comment.errors.full_messages }, status: :bad_request
    end
  end

  #Ensure Patch Request Only
  def update
    begin
      # filling in missing params, sanitising input
      comment_update_params[:comment_id] = @comment[:comment_id]
      comment_update_params[:post_id]    = @comment[:post_id]
      comment_update_params[:user_id]    = @comment[:user_id]
      comment_update_params[:body]       = Sanitize.clean(comment_update_params[:body].strip)

      @comment.update!(comment_update_params)
    rescue ActionController::ParameterMissing
      render json: { status: "error", message: "'Body' Parameter Missing" }, status: :bad_request
      return
    rescue ActiveRecord::RecordInvalid
      render json: { status: "error", message: @comment.errors.full_messages }, status: :bad_request
      return
    end

    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource.new(@comment, current_user: current_user) }, status: :ok
  end

  def destroy
    # This will not delete replies to this comments
    @comment.update_attribute(:body, "[deleted]")
    @comment.update_attribute(:user_id, nil)
    render json: { status: "success", data: @comment }, status: :ok
  end

  def like
    like = CommentsLike.find_by(user_id: current_user[:id], comment_id: @comment[:id])

    if like
      like.destroy
    else
      CommentsDislike.find_by(user_id: current_user[:id], comment_id: @comment[:id]).try(:destroy)
      CommentsLike.create(user_id: current_user[:id], comment_id: @comment[:id])
    end
  end

  def dislike
    dislike = CommentsDislike.find_by(user_id: current_user[:id], comment_id: @comment[:id])

    if dislike
      dislike.destroy
    else
      CommentsLike.find_by(user_id: current_user[:id], comment_id: @comment[:id]).try(:destroy)
      CommentsDislike.create(user_id: current_user[:id], comment_id: @comment[:id])
    end
  end

  private
  def authenticate
    unless user_signed_in?
      render json: { status: "error", message: "You must be signed in!" }
    end
  end

  def find_comment(id)
    begin
      @comment = Comment.find(id)
    rescue ActiveRecord::ActiveRecordError
      render json: { status: "error", message: "Comment Not Found" }, status: :not_found
      return
    end
    @comment
  end

  def check_correct_user
    if @comment[:user_id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naughty! Don't touch other people's comments!" }
    end
  end

  def comment_create_params
    params.require(:comment).permit(:body, :comment_id, :post_id)
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end

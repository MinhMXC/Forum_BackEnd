class CommentsController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy, :like]
  def show
    comment = find_comment(params[:id])
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource.new(comment, current_user: current_user)
    }, status: :ok if comment
  end

  def create
    comment = Comment.new(comment_create_params)
    comment[:user_id] = current_user[:id]

    post = Post.find(comment[:post_id])
    if post[:deleted]
      render json: { status: "error", message: "Can't reply to deleted posts!" }, status: :bad_request
      return
    end

    if comment[:comment_id] != nil
      comment_parent = Comment.find(comment[:comment_id])
      if comment_parent
        if comment_parent[:deleted]
          render json: { status: "error", message: "Can't reply to deleted comments!" }, status: :bad_request
          return
        end
      else
        render json: { status: "error", message: comment_parent.errors.full_messages }, status: :bad_request
        return
      end
    end

    if comment.save
      render json: { status: "success", data: comment }, status: :created
    else
      render json: { status: "error", message: comment.errors.full_messages }, status: :bad_request
    end
  end

  #Ensure Patch Request Only
  def update
    comment = find_comment(params[:id])
    return unless comment

    if comment[:user_id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naught! Don't update other people comments!" }
      return
    end

    if comment[:deleted]
      render json: { status: "error", message: "Can't update deleted comments!" }
      return
    end

    begin
      # filling in missing params
      comment_update_params[:comment_id] = comment[:comment_id]
      comment_update_params[:post_id]    = comment[:post_id]
      comment_update_params[:user_id]    = comment[:user_id]

      comment.update!(comment_update_params)
    rescue ActionController::ParameterMissing
      render json: { status: "error", message: "'Body' Parameter Missing" }, status: :bad_request and return
    rescue ActiveRecord::RecordInvalid
      render json: { status: "error", message: comment.errors.full_messages }, status: :bad_request and return
    end

    render json: { status: "success", data: comment }, status: :ok
  end

  def destroy
    # This will not delete replies to this comments

    comment = find_comment(params[:id])
    return unless comment

    if comment[:user_id] != current_user[:id]
      render json: { status: "error", message: "Naughty Naught! Don't update other people comments!" }, status: :unauthorized
      return
    end

    comment.update_attribute(:body, "[deleted]")
    comment.update_attribute(:deleted, true)
    render json: { status: "success", data: comment }, status: :ok
  end

  def like
    comment = find_comment(params[:id])
    return unless comment

    like = CommentsLike.find_by(user_id: current_user[:id], comment_id: params[:id])

    if like
      like.destroy
    else
      CommentsDislike.find_by(user_id: current_user[:id], comment_id: params[:id]).try(:destroy)
      CommentsLike.create(user_id: current_user[:id], comment_id: params[:id])
    end
  end

  def dislike
    comment = find_comment(params[:id])
    return unless comment

    dislike = CommentsDislike.find_by(user_id: current_user[:id], comment_id: params[:id])

    if dislike
      dislike.destroy
    else
      CommentsLike.find_by(user_id: current_user[:id], comment_id: params[:id]).try(:destroy)
      CommentsDislike.create(user_id: current_user[:id], comment_id: params[:id])
    end
  end

  private
  def comment_create_params
    params.require(:comment).permit(:body, :comment_id, :post_id)
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end

  def authenticate
    unless user_signed_in?
      render json: { status: "error", message: "You must be signed in!" }
    end
  end

  def find_comment(id)
    begin
      comment = Comment.find(id)
    rescue ActiveRecord::ActiveRecordError
      render json: { status: "error", message: "Comment Not Found" }, status: :not_found and return
    end
    comment
  end
end

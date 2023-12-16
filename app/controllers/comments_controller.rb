class CommentsController < ApplicationController
  def show
    comment = find_comment(params[:id])
    render json: { status: "success",
                   data: ActiveModelSerializers::SerializableResource.new(comment)
    }, status: :ok if comment
  end

  def create
    comment = Comment.new(comment_create_params)

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
    comment = find_comment(params[:id])
    return unless comment

    # This will not delete reply to this comments

    comment.update_attribute(:body, "[deleted]")
    render json: { status: "success", data: comment }, status: :ok
  end



  private
  def comment_create_params
    params.require(:comment).permit(:body, :comment_id, :post_id, :user_id)
  end

  def comment_update_params
    params.require(:comment).permit(:body)
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

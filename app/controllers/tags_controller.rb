class TagsController < ApplicationController
  def index
    render json: { status: "success", data: ActiveModelSerializers::SerializableResource.new(Tag.all) }
  end

  def create
    tag = Tag.create(tag_create_update_params)

    if tag.save
      render json: { status: "success", data: tag }, status: :created
    else
      render json: { status: "error", message: tag.errors.full_messages }, status: :bad_request
    end
  end

  private
  def tag_create_update_params
    params.require(:tag).permit(:tag_text, :colour)
  end
end

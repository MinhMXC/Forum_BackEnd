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

  def update
    tag = find_tag(params[:id])
    return unless tag

    if tag.update(tag_create_update_params)
      render json: { status: "success", data: tag }, status: :ok
    else
      render json: { status: "error", message: tag.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    tag = find_tag(params[:id])
    return unless tag

    tag.destroy_all
    render json: { status: "success", data: nil }, status: :ok
  end



  private
  def tag_create_update_params
    params.require(:tag).permit(:tag_text, :colour)
  end

  def find_tag(id)
    begin
      tag = Tag.find(id)
    rescue ActiveRecord::RecordNotFound
      render json: { status: "error", message: "Tag Not Found" }, status: :not_found and return
    end
    tag
  end

end

class TagSerializer < ActiveModel::Serializer
  attributes :id, :tag_text, :colour
end

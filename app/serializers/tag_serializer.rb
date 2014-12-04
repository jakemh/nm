class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :business_id
  # has_one :business, embed: :id
  def business_id
    object.taggable.id
  end
end

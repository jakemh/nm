class PostSerializer < ActiveModel::Serializer
  attributes :parent_id, :id, :type, :subject, :content, :entity_type, :entity_id, :created_at
  has_many :responses, embed: :ids
  has_one :user, embed: :id
  has_one :business, embed: :id
end

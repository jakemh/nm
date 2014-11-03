class PostSerializer < ActiveModel::Serializer
  attributes :parent_id, :id, :type, :subject, :content, :created_at
  has_many :responses, embed: :ids
  has_one :user, embed: :id
  has_one :business, embed: :id
end

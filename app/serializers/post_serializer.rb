class PostSerializer < ActiveModel::Serializer
  attributes :parent_id, :id, :type, :subject, :content, :created_at
  attributes :points
  has_many :responses, embed: :ids
  has_one :user, embed: :id
  has_one :business, embed: :id

  def points
    object.total_points
  end

end

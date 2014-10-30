class UserSerializer < EntitySerializer
  attributes :user_post_associations, :business_post_associations, :message_route
  has_many :businesses, embed: :ids
  has_many :posts, embed: :ids

  def posts
    Post.all.where(type: [nil, "", "Post"])
  end

  def message_route
    "users/#{object.id}/messages"
  end

  def user_post_associations
  	posts.select{|p| p.user_id}.map{|p| p.user_id}
  end

  def business_post_associations
  	posts.select{|p| p.business_id}.map{|p| p.business_id}

  end
end

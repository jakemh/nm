class UserSerializer < EntitySerializer
  attributes :user_post_associations, :business_post_associations, :message_route

  # :response_post_associations,

  has_many :businesses, embed: :ids
  has_many :posts, embed: :ids
  has_many :personal_posts, embed: :ids
  # has_many :personal_posts

  def posts
    Post.all.where(type: [nil, "", "Post"])
    # object.posts.where(type: [nil, "", "Post"])
  end

  def personal_posts
    object.posts.where(type: [nil, "", "Post"])
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

  # def business_post_associations
  #   posts.select{|p| p.response_}.map{|p| p.business_id}
  # end
end

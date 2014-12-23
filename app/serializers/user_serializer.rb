 class UserSerializer < EntitySerializer
  attributes :user_post_associations, :business_post_associations, :message_route
  attributes :about, :work
  attributes :is_admin
  # :response_post_associations,
  attributes :first_name, :last_name
  has_many :businesses, embed: :ids
  has_many :posts, embed: :ids
  # has_many :personal_posts
  has_many :friendships, embed: :id
  has_many :business_connections, embed: :id
  has_many :friends, embed: :id
  has_many :connected_businesses, embed: :id

  has_many :user_connections, embed: :ids
  has_many :business_connections, embed: :ids
  
  def business_connections
    object.connected_businesses
  end

  def user_connections
    object.friends
  end

  def is_admin
    object.role? "Admin"
  end
  # def friendships
  #   object.friendships
  # end

  # def business_connections
  #   object.business_connections

  # end
  def name
    "#{first_name + " " + last_name}"
  end

  def first_name
    if object.first_name
      scope.cap_first(object.first_name) 
    else 
      ""
    end
  end

  def last_name
    if object.last_name
      scope.cap_first(object.last_name)   
    else 
      ""
    end
  end

  def posts
    Post.all.where(type: [nil, "", "Post"])
    # object.posts.where(type: [nil, "", "Post"])
  end



  def message_route
    "users/#{object.id}/messages"
  end

  def user_post_associations
  	Response.all.select{|p| p.user_id}.map{|p| p.user_id}
  end

  def business_post_associations
  	Response.all.select{|p| p.business_id}.map{|p| p.business_id}
  end

  # def business_post_associations
  #   posts.select{|p| p.response_}.map{|p| p.business_id}
  # end
end

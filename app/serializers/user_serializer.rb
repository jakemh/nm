class UserSerializer < EntitySerializer
  has_many :businesses, embed: :ids
  has_many :posts, embed: :ids


  def posts
    Post.all.where(type: [nil, "", "Post"])
  end

end

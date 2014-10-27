class UserSerializer < EntitySerializer
  has_many :businesses, embed: :ids
end

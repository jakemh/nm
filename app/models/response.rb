class Response < Post
  # belongs_to :post
  belongs_to :post, :foreign_key => :parent_id
end

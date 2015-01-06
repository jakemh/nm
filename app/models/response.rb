class Response < Post
  # belongs_to :post
  belongs_to :post, :foreign_key => :parent_id
  PARENT_ALIAS = "parents"

  def self.joins_parents(options = {})
    col_alias = options[:as] || "parents"
    Response.joins("INNER JOIN posts AS #{col_alias} ON #{col_alias}.id = posts.parent_id")
  end

end

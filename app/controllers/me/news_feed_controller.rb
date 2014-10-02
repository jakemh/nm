class Me::NewsFeedController < MeController
  
  layout "profile"
  
  def index
    post_attrs = [:content, :user_id, :business_id, :type, :created_at]
    # @posts = current_user.posts.select post_attrs
    @posts = Post.all.select(post_attrs).sort_by{|p| p.created_at }.reverse
    @post = Post.new
    @select = [["User Account", ["User", current_user.id, current_user.thumb || "null"]]] + current_user.businesses.collect{|b|[b.name,["Business", b.id, b.thumb || "null"]]}
  end
end

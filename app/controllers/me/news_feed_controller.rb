class Me::NewsFeedController < MeController
  
  layout "profile"
  
  def index
    post_attrs = [:content, :user_id, :business_id, :type, :created_at]
    # @posts = current_user.posts.select post_attrs
    @posts = Post.includes(:responses).all.where(:type => nil)
    .sort_by{|p| p.created_at }.reverse

    # .select(post_attrs)
    @post = Post.new
    @select = [
      ["User Account", 
        ["User", current_user.id, current_user.thumb || view_context.image_path("default_person.png"), current_user.name]]] + 
        current_user.businesses.collect{|b|[b.name,["Business", b.id, b.thumb || view_context.image_path("default_business.png"), b.name]
      ]}
  end
end

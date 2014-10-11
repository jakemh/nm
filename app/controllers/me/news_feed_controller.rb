class Me::NewsFeedController < MeController
  
  layout "profile"
  include FeedConcern
  def index
    @posts = build_sorted_posts(Post.all.where(type: [nil, ""]))
    @default_entity = current_user
    @post = Post.new
    @select = select_array
  end
end

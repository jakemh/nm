class Me::NewsFeedController < ApplicationController
  
  layout "profile"
  
  def index
    post_attrs = [:content, :user_id, :business_id, :type]
    # @posts = current_user.posts.select post_attrs
    @posts = Post.all.select post_attrs
    @select = [["User Account", ["User", current_user.id, current_user.thumb]]] + current_user.businesses.collect{|b|[b.name,["Business", b.id, b.thumb]]}
  end
end

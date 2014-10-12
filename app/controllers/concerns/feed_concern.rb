module FeedConcern
  extend ActiveSupport::Concern

  included do
    attr_reader :sorted_parent_posts, :select_array
  
    # before_filter :build_sorted_posts
    before_filter :build_select_array
  end

  def build_sorted_posts(posts)
    post_attrs = [:content, :user_id, :business_id, :type, :created_at]
    # @posts = current_user.posts.select post_attrs
    @sorted_parent_posts = posts.includes(:responses)
    .sort_by{|p| p.created_at }.reverse
  end

  def build_select_array
    @select_array = [
      ["User Account", 
        ["User", current_user.id, current_user.thumb || view_context.image_path("default_person.png"), current_user.name]]] + 
        current_user.businesses.collect{|b|[b.name,["Business", b.id, b.thumb || view_context.image_path("default_business.png"), b.name]
      ]}
  end

end
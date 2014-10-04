class Me::AudienceController < MeController
  def index
    @interacted_with = current_user.interacted_with
  # @posts = current_user.posts.select post_attrs
  
  # .select(post_attrs)
  @entity = current_user.businesses.first
  @select = current_user.businesses.collect do |b|
    [b.name,["Business", b.id, b.thumb || view_context.image_path("default_business.png"), b.name]]
  end

  end
end
 
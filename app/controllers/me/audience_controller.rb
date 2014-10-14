class Me::AudienceController < MeController
  layout "profile"
  def index
    @interacted_with = current_user.interacted_with
    
    @entity ||= current_user.businesses.first    
    @entity = current_user.businesses.find(params[:business_id]) if params[:business_id]


    @select = current_user.businesses.collect do |b|
      [b.name,["Business", b.id, b.thumb || view_context.image_path("default_business.png"), b.name]]
    end
    respond_to do |format|
      format.html

      #prevent paloma from executing
      format.js { render :file => "me/audience/index.js.erb" }


    end
  end
end


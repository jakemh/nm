module ApplicationHelper
  def formatted_date(date)
    date.in_time_zone("Eastern Time (US & Canada)").strftime('%b %e, %l:%M %p')
  end

  def cap_first(string)
    string.gsub!(/^\s*\w|\s+\w/){|s| s.upcase}
    return string
  end

  def model_name(model)
    model.to_s.downcase.pluralize.titleize
  end

  # def entity
  #    p "SET ENTITY"
  #   if params[:business_id]
  #      p params[:business_id]
  #     return Business.find(params[:business_id])
  #     p "ENTITY: ", @entity
  #   elsif params[:user_id]
  #     return  User.find(params[:user_id]) 
  #    else raise "Applicable entity not found!"

  #    end
  # end
  
  # def parse_show_array(model)
  #   models = []
  #   ids = params[:id].split(",")
  #   @models = if ids.length == 1
  #     # current_user.businesses.find(params[:id].split(","))
  #     model.find(ids[0])
  #   elsif ids.length > 1
  #     model.find(ids)
  #   else current_user.businesses
  #   end
  #   return models
  # end
end

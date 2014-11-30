module ApplicationHelper
  def formatted_date(date)
    date.in_time_zone("Eastern Time (US & Canada)").strftime('%b %e, %l:%M %p')
  end

  def entity
     p "SET ENTITY"
    if params[:business_id]
       p params[:business_id]
      return Business.find(params[:business_id])
      p "ENTITY: ", @entity
    elsif params[:user_id]
      return  User.find(params[:user_id]) 
     else raise "Applicable entity not found!"

     end
  end
  
end

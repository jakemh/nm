module ApplicationHelper
  def formatted_date(date)
    date.in_time_zone("Eastern Time (US & Canada)").strftime('%b %e, %l:%M %p')
  end

  
end

module ProfileHelper

  def show_badge(quant)
    p "***: ", quant
    if quant > 0
      return content_tag :span, quant, class: "badge pull-right"    
    end
  end

  def quant_from_hash(key)
    badges[key]
  end

  def quant_from_method(method)
    begin
      if method
        return send(method)
      else
        return 0
      end
    rescue NoMethodError
      return 0
    end
  end 

  # def badges
  #   {
  #     me_feed_badge: 0,
  #     me_message_badge: me_message_badge,
  #     me_connections_badge: 0,
  #     me_audience_badge: 0,
  #     business_badge: 0
  #   }
  # end 

  def me_feed_badge
    0
  end

  def me_message_badge
    current_user.message_recipients.unread_by(current_user).count
  end

  def me_connections_badge
    0
  end

  def me_audience_badge
    0
  end

  def business_badge
    0
  end
end

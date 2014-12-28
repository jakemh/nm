module Admin::AlertsHelper
  def highlight_row_post(obj, conditions = nil)
    if obj.total_points <= -10
      return  :class => "nm__orange--light"
    else return nil
    end
  end
end

module Me::AudienceHelper

  def audience_filter_options
    [:all, :businesses_only, :industry, :type, :followers]
  end

  def audience_sort_options
    [:date, :distance]
  end
end

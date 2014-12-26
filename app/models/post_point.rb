class PostPoint < Point
  # validate :valid_time_frame

  def self.valid_time_frame
    24.hours
  end

  def self.validate_time_frame(compare_against)
    compare_against.each do |point|
      if point.created_at + PostPoint.valid_time_frame > Time.now
        return false
      end
    end

    return true
  end
end
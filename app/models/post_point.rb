class PostPoint < Point
  validate :valid_score

  def valid_score
    self.score.abs == 1
  end

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
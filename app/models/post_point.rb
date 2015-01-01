class PostPoint < Point
  validate :valid_score

  def valid_score
    self.score.abs == 1
  end

  def self.valid_time_frame
    24.hours
  end

  def valid_vote?(post, condition)
    sum = PostPoint.sum_for(post, condition)
    if sum.abs > 1 #edge case 
      return (sum + self.score).abs < sum.abs
    else 
      return (sum + self.score).abs <= 1
    end
  end

  def self.already_voted?(compare_against)
    return compare_against.compact.length > 0
  end

  def self.validate_time_frame(compare_against)
    compare_against.each do |point|
      if point.created_at + PostPoint.valid_time_frame > Time.now
        return false
      end
    end

    return true
  end



  def self.sum_for(post, condition = nil)
    PostPoint.where(:pointable_id => post.id, :pointable_type => "Post")
    .where(condition)
    .sum(:score)

  end
end
class PostSerializer < ActiveModel::Serializer

  include SqlConcern 
  
  attributes :parent_id, :id, :type, :subject, :content, :created_at
  attributes :points, :existing_score
  has_many :responses, embed: :ids
  has_one :user, embed: :id
  has_one :business, embed: :id

  def points
    object.total_points
  end

  def existing_score
    PostPoint.sum_for(object, entity_condition(scope.current_user))
  end

  def existing_vote
    if scope.current_user
      scope.current_user.owned_entity_last_votes(object).last.score
    end
  end

  # def last_vote_current_user
  #   if scope
  #     votes = scope.current_user.owned_entity_last_votes(object)
  #     if votes.length > 0
  #       return votes.sort_by{|v|v.created_at}.last.created_at
  #     else return nil
  #     end
  #   end
  # end

end

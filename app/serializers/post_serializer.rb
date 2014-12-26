class PostSerializer < ActiveModel::Serializer
  attributes :parent_id, :id, :type, :subject, :content, :created_at
  attributes :points, :last_vote_current_user
  has_many :responses, embed: :ids
  has_one :user, embed: :id
  has_one :business, embed: :id

  def points
    object.total_points
  end

  def last_vote_current_user
    votes = scope.current_user.owned_entity_last_votes(object)
    if votes.length > 0
      return votes.sort_by{|v|v.created_at}.last.created_at
    else return nil
    end
  end

end

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :score, :content, :user_id



  # def business_id
  #   object.reviewable.id
  # end

end

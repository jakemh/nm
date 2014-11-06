class SkillSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user, embed: :id
end

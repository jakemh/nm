class MessageSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user, embed: :id, include: false
  has_one :business,  embed: :id, include: false
end

class MessageSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user, embed: :id
  has_one :business,  embed: :id
end

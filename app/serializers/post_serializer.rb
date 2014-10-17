class PostSerializer < ActiveModel::Serializer
  attributes :id, :type, :subject, :content, :entity_type, :entity_id
end

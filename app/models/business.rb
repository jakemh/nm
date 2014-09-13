class Business < ActiveRecord::Base
  has_many :owernships
  has_many :users, :through => :ownerships
  has_many :tags, :as => :taggable

  accepts_nested_attributes_for :tags
end

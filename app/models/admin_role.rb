class AdminRole < ActiveRecord::Base
  has_one :role, as: :roleable
  has_many :assignments
end

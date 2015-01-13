class AdminRole < ActiveRecord::Base
  has_one :role, as: :roleable
  has_many :assignments
  validates :status, uniqueness: true
  enum status: [:super]

end

class MentorRole < ActiveRecord::Base
  has_one :role, as: :roleable
  has_many :assignments

  validates :category, uniqueness: true, presence: true
  enum category: [:general]
end

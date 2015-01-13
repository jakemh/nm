class Affiliation < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :branch

  validates :branch_id, uniqueness: {scope: :user_id}
end

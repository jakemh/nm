class Affiliation < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :branch
end

class Branch < ActiveRecord::Base
  has_many :assignments
  has_many :users, through: :assignments
  validates :name, presence: true, uniqueness: true  
  
  # enum: 
  def self.names
    Branch.all.pluck :name
  end
end

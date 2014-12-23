class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments

  def self.enum(type)
    hash = {
      admin: 1
    }

    hash[type.intern]
  end

end

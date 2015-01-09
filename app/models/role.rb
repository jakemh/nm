# class Role < ActiveRecord::Base
#   has_many :assignments
#   has_many :users, :through => :assignments
#   # enum name: [ :admin, :mentor]

#   def self.enum(type)
#     hash = {
#       admin: 1
#       mentor: 2
#     }
#     hash[type.intern]
#   end

# end


class Role < ActiveRecord::Base
  # has_many :assignments
  has_many :users, :through => :assignments
  belongs_to :roleable, polymorphic: true

  # enum name: [ :admin, :mentor]

  def self.enum(type)
    hash = {
      admin: 1,
      mentor: 2
    }
    hash[type.intern]
  end

end
 
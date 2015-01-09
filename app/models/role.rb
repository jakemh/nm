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
  belongs_to :roleable, polymorphic: true, dependent: :destroy
  validates :roleable_id, presence: true
  validates :roleable_type, presence: true
  validates :roleable_id, uniqueness: { scope: :roleable_type, message: "This role type has already been created"}
  
  # validates :roleable, uniqueness: true
  # enum name: [ :admin, :mentor]

  # def self.enum(type)
  #   hash = {
  #     admin: 1,
  #     mentor: 2
  #   }
  #   hash[type.intern]
  # end

  def self.add(model_constant, options = {})
    roleObj = model_constant.where(options).first
    roleObj.role
  end

end
 
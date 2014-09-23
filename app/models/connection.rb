class Connection < ActiveRecord::Base
  # belongs_to :user
  validates :connect_to_id, :uniqueness => {:scope => [:user_id, :type]}

  def pending?
    !has_corresponding_inverse
  end

  def has_corresponding_inverse
    Connection.where(:user_id => self.connect_to_id, :connect_to_id => self.user_id, :type => self.type).length > 0
  end
end

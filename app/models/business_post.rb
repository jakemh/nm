class BusinessPost < Post
  belongs_to :business

  def image
    self.business.image
  end
end

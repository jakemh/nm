class RegistrationController < ApplicationController
  before_filter :authenticate_user!
  
  def selection
    @business = Business.new

  end
end

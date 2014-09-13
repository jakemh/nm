require 'spec_helper'

describe RegistrationController do

  describe "GET 'selection'" do
    it "returns http success" do
      get 'selection'
      response.should be_success
    end
  end

end

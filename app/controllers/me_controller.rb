class MeController < ApplicationController
  before_filter :authenticate_user!

  # layout 'layouts/profile'
end

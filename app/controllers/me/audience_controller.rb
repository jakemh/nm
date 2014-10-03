class Me::AudienceController < MeController
  def index
    @interacted_with = current_user.interacted_with
  end
end

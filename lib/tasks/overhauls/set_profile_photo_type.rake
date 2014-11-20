namespace :overhaul do
  desc "Set profile photo type"
  task :set_profile_photo_type => :environment do
    p "SETTING PROFILE PHOTO TYPE"
    Photo.all.each{|p| p.update_attributes(:type => "ProfilePhoto")}
    p "FINISHED SETTING PROFILE PHOTO TYPE"
  end

end
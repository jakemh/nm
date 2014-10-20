namespace :overhaul do
  desc "this will migrate int zips to string"
  task migrate_int_zips_to_string: :environment do
    Business.all.each do |b|
      p "ZIP: ", b.zip
      b.update_attributes(zip_string: b.zip.to_s)
      p "ZIP STRING: ", b.zip_string
      b.save
    end
  end

end

ActionMailer::Base.delivery_method = :smtp # or :sendmail, or whatever
ActionMailer::Base.smtp_settings = {
  :method => :smtp,
  :from   => 'next.mission.notifier@gmail.com',
  :to     => 
  :github => 'nextmission/nextmission-core.git',
  :smtp_settings => {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "next.mission.notifier",
    password: ENV["capistrano_email_password"]
  }
}

ActionMailer::Base.delivery_method = :smtp # or :sendmail, or whatever
ActionMailer::Base.smtp_settings = { # if using :smtp
                                     address: "smtp.gmail.com",
                                     port: 587,
                                     domain: "gmail.com",
                                     authentication: "login",
                                     enable_starttls_auto: true,
                                     user_name: "next.mission.notifier",
                                     password: ENV["capistrano_email_password"]

                                     }
ActionMailer::Base.default_charset = "utf-8"# or "latin1" or whatever you are using

CapMailer.configure do |config|
  config[:recipient_addresses]  = ['daniel.mcfarland@gmail.com', 'jashton76@gmail.com', 'jakemh@gmail.com'],
  # NOTE: THERE IS A BUG IN RAILS 2.3.3 which forces us to NOT use anything but a simple email address string for the sender address.
  # https://rails.lighthouseapp.com/projects/8994/tickets/2340
  # Therefore %("Capistrano Deployment" <releases@example.com>) style addresses may not work in Rails 2.3.3
  config[:sender_address]       = "next.mission.notifier@gmail.com"
  config[:subject_prepend]      = "There's been a deployment!"
  config[:site_name]            = "nextmission.us"
end

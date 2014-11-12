ActionMailer::Base.delivery_method = :smtp # or :sendmail, or whatever
ActionMailer::Base.smtp_settings = {
  :method => :smtp,
  :from   => 'next.mission.notifier@gmail.com',
  :to     => ['daniel.mcfarland@gmail.com', 'jashton76@gmail.com'],
  :github => 'nextmission/nextmission-core.git',
  :smtp_settings => {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "next.mission.notifier",
    password: MY_PASSWORD
  }
}
class ApplicationMailer < ActionMailer::Base
  default from: "notification@pitchhub.net"
  layout 'mailer'
end

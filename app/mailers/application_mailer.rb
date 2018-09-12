class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_USER')
  layout 'mailer'
end

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:mail, :sender)
  layout "mailer"
end

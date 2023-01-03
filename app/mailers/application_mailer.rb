# frozen_string_literal: true

# This is your application mailer
class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:mail, :sender)
  layout 'mailer'
end

# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'gullsher.khan@devsinc.com'
  layout 'mailer'
end

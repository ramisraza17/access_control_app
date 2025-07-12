class ParentalConsentMailer < ApplicationMailer
  def consent_request(user)
    @user = user
    @token = user.consent_token
    mail(to: @user.parent_email, subject: 'Consent Required for Account Access')
  end
end

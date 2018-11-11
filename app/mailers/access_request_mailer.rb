class AccessRequestMailer < ApplicationMailer
  def accept(request, user, code, locale)
    @request = request
    @user = user
    @code = code

    subject = I18n.with_locale(locale) do
      I18n.t('mailer.access_request_mailer.accept.subject')
    end

    mail(to: request.email, subject: subject)
  end

  def reject(request, locale)
    @request = request

    subject = I18n.with_locale(locale) do
      I18n.t('mailer.access_request_mailer.reject.subject')
    end

    mail(to: request.email, subject: subject)
  end
end

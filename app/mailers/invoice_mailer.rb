class InvoiceMailer < ApplicationMailer
  def send_customer(invoice, customer)
    @invoice = invoice
    @customer = customer

    subject = I18n.with_locale(locale) do
      I18n.t('mailer.invoice.send_customer.subject', company_name: Company.first.name)
    end

    attachments["invoice.pdf"] = @invoice.pdf.blob.download

    mail(to: customer.email, subject: subject)
  end
end

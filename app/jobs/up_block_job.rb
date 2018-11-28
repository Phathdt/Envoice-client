class UpBlockJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    invoice.reload

    TransactionGeneratorJob.perform_now(invoice)
    InvoiceMailer.send_customer(invoice, invoice.customer).deliver_now
  end
end

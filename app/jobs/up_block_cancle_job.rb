class UpBlockCancleJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    invoice.reload

    InvoiceMailer.cancle_invoice(invoice, invoice.customer).deliver_now
    SyncDataCancleJob.perform_now(invoice)
  end
end

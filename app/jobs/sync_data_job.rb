class SyncDataJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    invoice.reload

    payload = {
      invoice: invoice.slice(:form_identifier, :serial_number, :invoice_number,:invoice_date, :payment_method, :vat_percent, :transaction_id, :hash_data).merge(
        pdf: File.open(ActiveStorage::Blob.service.send(:path_for, invoice.pdf.key)),
        image: File.open(ActiveStorage::Blob.service.send(:path_for, invoice.image.key))
      )
    }

    header = {
      content_type: :json,
      accept: :json,
      accessToken: ENV['ACCESS_TOKEN']
    }

    RestClient.post("#{ENV['ADMIN_HOST']}/api/v1/invoices", payload, header)
  end
end

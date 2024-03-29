class SyncDataJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    invoice.reload

    payload =
      if Rails.env.production?
        pdf_path = RestClient::Request.execute(method: :get, url: invoice.pdf.service_url, raw_response: true).file.path
        {
          invoice: invoice.slice(:form_identifier, :serial_number, :invoice_number,:invoice_date, :payment_method, :vat_percent, :transaction_id, :hash_data).merge(
            pdf: File.open(pdf_path),
            customer_name: invoice.customer.name,
            paid_amount: invoice.paid_amount,
          )
        }
      else
        {
          invoice: invoice.slice(:form_identifier, :serial_number, :invoice_number,:invoice_date, :payment_method, :vat_percent, :transaction_id, :hash_data).merge(
            pdf: File.open(ActiveStorage::Blob.service.send(:path_for, invoice.pdf.key)),
            customer_name: invoice.customer.name,
            paid_amount: invoice.paid_amount,
          )
        }
      end

    header = {
      accessToken: ENV['ACCESS_TOKEN']
    }

    response = RestClient.post("#{ENV['ADMIN_HOST']}/api/v1/invoices", payload, header)

    body = JSON.parse(response.body)

    invoice.update_column(:id_server, body['id'])
  end
end

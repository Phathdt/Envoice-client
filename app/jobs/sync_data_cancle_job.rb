class SyncDataCancleJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    invoice.reload

    header = {
      accessToken: ENV['ACCESS_TOKEN']
    }

    payload = {
      id: invoice.id_server
    }

    RestClient.patch("#{ENV['ADMIN_HOST']}/api/v1/invoices/cancle", payload ,header)
  end
end

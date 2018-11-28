class TransactionGeneratorJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    TransactionGenerator.perform(invoice)
  end
end

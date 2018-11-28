class InvoiceSerializer < ActiveModel::Serializer
  attributes :form_identifier, :serial_number , :invoice_number, :invoice_date, :total, :vat_percent, :vat_amount, :customer_paid_amount, :company, :customer, :items

  def customer_paid_amount
    object.paid_amount
  end

  def company
    CompanySerializer.new(Company.first).as_json
  end


  def customer
    CustomerSerializer.new(object.customer).as_json
  end

  def items
    object.items.map { |item| ItemSerializer.new(item).as_json}
  end
end

class CustomerSerializer < ActiveModel::Serializer
  attributes :buyer, :company, :tax_number, :address

  def buyer
    object.name
  end

  def company
    object.company_name
  end

  def tax_number
    object.tax_number
  end
end

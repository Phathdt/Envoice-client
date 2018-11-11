class CompanySerializer < ActiveModel::Serializer
  attributes :tax_number, :company_name, :address, :phone

  def tax_number
    object.tax_identification_number
  end

  def company_name
    object.name
  end

  def phone
    object.phone_number
  end
end

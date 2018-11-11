class ItemSerializer < ActiveModel::Serializer
  attributes :name, :unit, :quantity, :price, :total

  def name
    object.product.name
  end

  def unit
    object.product
  end
end

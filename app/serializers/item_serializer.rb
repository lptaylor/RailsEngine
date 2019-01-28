class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :unit_price, :merchant_id
end

class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
end

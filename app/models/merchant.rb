class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.random_record
    db_first = Merchant.first.id
    db_last = Merchant.last.id
    random = Random.new
    random.rand(db_first..db_last)
  end

  def self.merchants_by_revenue(limit)
    joins(invoice_items: :transactions)
        .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .where(transactions: {result: "success"})
        .group(:id)
        .order("revenue desc")
        .limit(limit)
  end

end

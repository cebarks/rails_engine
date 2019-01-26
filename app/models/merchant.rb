class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 1)
    Merchant.joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: "success"})
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order("total_revenue DESC")
    .group(:id)
    .limit(quantity)
  end

  def revenue
    Item.joins(:invoice_items)
    .where(merchant_id: self)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end

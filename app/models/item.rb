class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates_numericality_of :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    joins(:invoice_items, invoices: :transactions)
    .select("items.*", "sum(invoice_items.quantity) as items_sold")
    .where(transactions: {result: "success"})
    .order("items_sold DESC")
    .group(:id)
    .limit(quantity)
  end
end

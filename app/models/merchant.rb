require 'time'

class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 1)
    joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: "success"})
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order("total_revenue DESC")
    .group(:id)
    .limit(quantity)
  end

  def favorite_customer
    Customer.joins(:transactions, :invoices, invoices: {items: :invoice_items})
    .select("customers.*", "count(transactions.id) as trans_num")
    .where(transactions: {result: "success"})
    .order("trans_num DESC")
    .group(:id)
    .limit(1)
    .first
  end

  def revenue(raw_date = nil)
    result = Item.joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: "success"})
    .where(merchant_id: self)

    if raw_date
      date = DateTime.parse(raw_date)
      result.where(invoices: {created_at: date..date.at_end_of_day})
    else
      result
    end.sum('invoice_items.quantity * invoice_items.unit_price')
  end
end

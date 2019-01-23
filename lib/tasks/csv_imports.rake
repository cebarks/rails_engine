require 'csv'

namespace :import do
  desc "Import customers from CSV"
  task customers: :environment do
    CSV.foreach('./data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "Import invoice items from CSV"
  task invoice_items: [:environment, :items, :invoices] do
    CSV.foreach('./data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "Import invoices from CSV"
  task invoices: :environment do
    CSV.foreach('./data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "Import items from CSV"
  task items: [:environment, :merchants] do
    CSV.foreach('./data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "Import merchants from CSV"
  task merchants: :environment do
    CSV.foreach('./data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "Import transactions from CSV"
  task transactions: :environment do
    CSV.foreach('./data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc "Import all from CSV"
  task all: [:items, :customers, :invoice_items, :invoices,  :merchants, :transactions] do

  end
end

require 'csv'
desc "Import merchants from csv file"
task :import => [:environment] do
  file = "./data/merchants.csv"
  CSV.foreach(file, headers: true) do |row|
    Merchant.create(row.to_h)
  end
end
desc "Import customers from csv file"
  task :import => [:environment] do
   file = "./data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      Customer.create(row.to_h)
  end
end
desc "Import invoices from csv file"
  task :import => [:environment] do
   file = "./data/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
      Invoice.create!(row.to_h)
  end
end
desc "Import items from csv file"
  task :import => [:environment] do
   file = "./data/items.csv"
    CSV.foreach(file, headers: true) do |row|
      Item.create!(row.to_h)
  end
end
desc "Import invoice_items from csv file"
task :import => [:environment] do
  file = "./data/invoice_items.csv"
  CSV.foreach(file, headers: true) do |row|
    InvoiceItem.create!(row.to_h)
  end
end
desc "Import transactions from csv file"
  task :import => [:environment] do
   file = "./data/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
      Transaction.create!(row.to_h)
  end
end

require_relative 'csv_parser'
require_relative 'invoice_builder'

def total_by_month(users_transactions, month)
  users_transactions.select{|transaction|
    transaction[:date].month == month
  }.reduce(0){|total, transaction| 
    total + transaction[:amount].to_f 
  }
end

data = read_csv('lib/data/index.csv')
invoice = build_invoice_object(data)
kneecaps = total_by_month(invoice.first[1][:transactions], 3).round(2)
binding.pry
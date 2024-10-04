# frozen_string_literal: true

require_relative 'csv_parser'
require_relative 'invoice_builder'

def total_by_month(users_transactions, month)
  raise ArgumentError, 'Month must be between 1 and 12' if month < 1 || month > 12

  users_transactions.select  do |transaction|
    transaction[:date].month == month
  end.reduce(0) do |total, transaction|
    total + transaction[:amount].to_f
  end
end

data = read_csv('lib/data/index.csv')
invoice = build_invoice_object(data)
total_by_month(invoice.first[1][:transactions], 3).round(2)

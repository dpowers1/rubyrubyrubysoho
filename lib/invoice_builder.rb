# frozen_string_literal: true

def build_invoice_object(transactions)
  transactions_by_user = {}
  transactions.each do |transaction|
    date = Date.parse(transaction[:date])
    amount = transaction[:money]
    user = transaction[:card]

    transactions_by_user[user] ||= { total: 0.0, transactions: [] }
    transactions_by_user[user][:total] += amount.to_f
    transactions_by_user[user][:transactions] << { date:, amount: }
  end

  transactions_by_user
end

def total_by_month(users_transactions, month)
  raise ArgumentError, 'Month must be between 1 and 12' if month < 1 || month > 12

  users_transactions_by_month = users_transactions.select  do |transaction|
    transaction[:date].month == month
  end
  users_transactions_by_month.reduce(0) do |total, transaction|
    total + transaction[:amount].to_f
  end
end

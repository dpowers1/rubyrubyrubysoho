def build_invoice_object(transactions)
  transactions_by_user = {}
  transactions.each do |transaction|
    date = Date.parse(transaction[:date])
    amount = transaction[:money]
    user = transaction[:card]

    transactions_by_user[user] ||= { total: 0.0, transactions: [] }
    transactions_by_user[user][:total] += amount.to_f
    transactions_by_user[user][:transactions] << { date: date, amount: amount }
  end

  transactions_by_user
end

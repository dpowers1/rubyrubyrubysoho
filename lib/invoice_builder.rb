def build_invoice_object(data)
  transactions_by_user = {}
  data.each do |row|
    date = Date.strptime(row.fetch(:date), '%Y-%m-%d')
    amount = row.fetch(:money)
    user = row.fetch(:card)
    transactions_by_user[user] ||= []
    transactions_by_user[user].push({:date => date, :amount => amount})
  end

  transactions_by_user
end
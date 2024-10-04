require 'minitest/autorun'
require_relative '../lib/main.rb'

class TransactionCalculatorTest < Minitest::Test
  def test_total_by_month_returns_total_for_given_month
    users_transactions = [
      { date: Date.new(2022, 1, 1), amount: '10.99' },
      { date: Date.new(2022, 1, 15), amount: '20.00' },
      { date: Date.new(2022, 2, 1), amount: '30.00' },
      { date: Date.new(2022, 2, 15), amount: '40.00' }
    ]

    assert_equal 30.99, total_by_month(users_transactions, 1).round(2)
    assert_equal 70.00, total_by_month(users_transactions, 2).round(2)
    assert_equal 0.0, total_by_month(users_transactions, 3).round(2)
  end

  def test_total_by_month_returns_zero_for_empty_transactions
    assert_equal 0.0, total_by_month([], 1)
  end

  def test_total_by_month_raises_error_for_invalid_month
    assert_raises ArgumentError do
      total_by_month([{ date: Date.new(2022, 1, 1), amount: '10.99' }], 13)
    end
  end
end
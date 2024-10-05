# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/invoice_builder'

class InvoiceBuilderTest < Minitest::Test
  def test_build_invoice_object_returns_empty_hash_for_empty_transactions
    assert_equal({}, build_invoice_object([]))
  end

  def test_build_invoice_object_returns_invoice_object_for_single_transaction
    transaction = { date: '2022-01-01', money: '10.99', card: 'user1' }
    expected_result = {
      'user1' => { total: 10.99, transactions: [{ date: Date.parse('2022-01-01'), amount: '10.99' }] }
    }
    assert_equal expected_result, build_invoice_object([transaction])
  end

  def test_build_invoice_object_returns_invoice_object_for_multiple_transactions # rubocop:disable Metrics/MethodLength
    transactions = [
      { date: '2022-01-01', money: '10.99', card: 'user1' },
      { date: '2022-01-15', money: '20.00', card: 'user1' },
      { date: '2022-02-01', money: '30.00', card: 'user2' }
    ]
    expected_result = {
      'user1' => { total: 30.990000000000002, transactions: [
        { date: Date.parse('2022-01-01'), amount: '10.99' },
        { date: Date.parse('2022-01-15'), amount: '20.00' }
      ] },
      'user2' => { total: 30.00, transactions: [
        { date: Date.parse('2022-02-01'), amount: '30.00' }
      ] }
    }
    assert_equal expected_result, build_invoice_object(transactions)
  end

  def test_build_invoice_object_handles_transactions_with_different_cards # rubocop:disable Metrics/MethodLength
    transactions = [
      { date: '2022-01-01', money: '10.99', card: 'user1' },
      { date: '2022-01-15', money: '20.00', card: 'user2' },
      { date: '2022-02-01', money: '30.00', card: 'user3' }
    ]
    expected_result = {
      'user1' => { total: 10.99, transactions: [{ date: Date.parse('2022-01-01'), amount: '10.99' }] },
      'user2' => { total: 20.00, transactions: [{ date: Date.parse('2022-01-15'), amount: '20.00' }] },
      'user3' => { total: 30.00, transactions: [{ date: Date.parse('2022-02-01'), amount: '30.00' }] }
    }
    assert_equal expected_result, build_invoice_object(transactions)
  end

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

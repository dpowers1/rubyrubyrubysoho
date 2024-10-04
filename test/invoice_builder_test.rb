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

  def test_build_invoice_object_returns_invoice_object_for_multiple_transactions
    transactions = [
      { date: '2022-01-01', money: '10.99', card: 'user1' },
      { date: '2022-01-15', money: '20.00', card: 'user1' },
      { date: '2022-02-01', money: '30.00', card: 'user2' }
    ]
    expected_result = {
      'user1' => { total: 30.990000000000002, transactions: [
        { date: Date.parse('2022-01-01'), amount: '10.99' },
        { date: Date.parse('2022-01-15'), amount: '20.00' }
      ]},
      'user2' => { total: 30.00, transactions: [
        { date: Date.parse('2022-02-01'), amount: '30.00' }
      ]}
    }
    assert_equal expected_result, build_invoice_object(transactions)
  end

  def test_build_invoice_object_handles_transactions_with_different_cards
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
end

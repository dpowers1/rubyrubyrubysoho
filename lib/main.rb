# frozen_string_literal: true

require_relative 'csv_parser'
require_relative 'invoice_builder'

data = read_csv('lib/data/index.csv')
invoice = build_invoice_object(data)
total_by_month(invoice.first[1][:transactions], 3).round(2)

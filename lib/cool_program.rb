require_relative 'csv_parser'
require_relative 'invoice_builder'

data = read_csv('lib/data/index.csv')
invoice = build_invoice_object(data)

binding.pry
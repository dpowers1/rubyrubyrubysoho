# frozen_string_literal: true

require 'csv'

def read_csv(file_name)
  raise IOError, "File #{file_name} does not exist" unless File.exist?(file_name)

  data = CSV.read(file_name, headers: true, skip_blanks: true, header_converters: :symbol).map(&:to_h)

  raise IOError, "File #{file_name} does not have data" if data.empty?

  data
end

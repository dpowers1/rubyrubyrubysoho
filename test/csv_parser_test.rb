require 'minitest/autorun'
require 'csv'
require_relative '../lib/csv_parser'

class CSVReaderTest < Minitest::Test
  def test_read_csv_raises_error_if_file_does_not_exist
    file_name = 'non_existent_file.csv'
    assert_raises(IOError) { read_csv(file_name) }
  end

  def test_read_csv_raises_error_if_file_is_empty
    file_name = 'empty_file.csv'
    File.open(file_name, 'w') {}
    assert_raises(IOError) { read_csv(file_name) }
    File.delete(file_name)
  end

  def test_read_csv_returns_data_from_file
    file_name = 'test_file.csv'
    CSV.open(file_name, 'w') do |csv|
      csv << ['Name', 'Age']
      csv << ['John', 25]
      csv << ['Jane', 30]
    end
    expected_data = [
      { name: 'John', age: '25' },
      { name: 'Jane', age: '30' }
    ]
    assert_equal expected_data, read_csv(file_name)
    File.delete(file_name)
  end

  def test_read_csv_skips_blank_lines
    file_name = 'test_file.csv'
    CSV.open(file_name, 'w') do |csv|
      csv << ['Name', 'Age']
      csv << ['John', 25]
      csv << []
      csv << ['Jane', 30]
    end
    expected_data = [
      { name: 'John', age: '25' },
      { name: 'Jane', age: '30' }
    ]
    assert_equal expected_data, read_csv(file_name)
    File.delete(file_name)
  end

  def test_read_csv_converts_headers_to_symbols
    file_name = 'test_file.csv'
    CSV.open(file_name, 'w') do |csv|
      csv << ['Name', 'Age']
      csv << ['John', 25]
    end
    expected_data = [
      { name: 'John', age: '25' }
    ]
    assert_equal expected_data, read_csv(file_name)
    File.delete(file_name)
  end
end

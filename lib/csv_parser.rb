require 'csv'
require 'pry'

def read_csv(file_name)
  if !File.exist?(file_name)
    puts "File #{file_name} does not exist"
    exit
  end

  data = CSV.read(file_name, headers:true, skip_blanks:true, header_converters: :symbol).map(&:to_h)

  if (data.empty?)
    puts "File #{file_name} is empty"
    exit
  end

  data
end
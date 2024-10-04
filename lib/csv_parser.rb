require 'csv'

def read_csv(file_name)
  if !File.exist?(file_name)
    raise IOError, "File #{file_name} does not exist"
  end

  data = CSV.read(file_name, headers:true, skip_blanks:true, header_converters: :symbol).map(&:to_h)

  if (data.empty?)
    raise IOError, "File #{file_name} does not have data"
  end

  data
end
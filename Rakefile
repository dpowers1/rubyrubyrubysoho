# frozen_string_literal: true

require 'rubocop/rake_task'
task default: %w[lint test]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

task :run do
  ruby 'lib/main.rb'
end

task :test do
  Dir['test/*_test.rb'].each { |f| ruby f }
end

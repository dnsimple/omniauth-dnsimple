require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "yard"

# By default, run tests and linter.
task default: [:spec, :rubocop]

RSpec::Core::RakeTask.new do |t|
  t.verbose = !ENV["VERBOSE"].nil?
end

RuboCop::RakeTask.new

YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end

namespace :yardoc do
  task :clobber do
    rm_r "yardoc" if File.directory?("yardoc")
  end
end

task clobber: "yardoc:clobber"

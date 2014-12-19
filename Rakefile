require "rspec/core/rake_task"
require "bundler/gem_tasks"

RSpec::Core::RakeTask.new(:spec)

desc "Run rubocop"
task :rubocop do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end

task default: [:spec, :rubocop]

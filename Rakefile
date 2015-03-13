require "bundler/gem_tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

require "gem_publisher"

desc "Publish gem to RubyGems.org"
task :publish_gem do |t|
  gem_filename = GemPublisher.publish_if_updated("govuk-content-schema-test-helpers.gemspec", :rubygems)
  puts "Published #{gem_filename}" if gem_filename
end

task :default => :spec

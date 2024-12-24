# frozen_string_literal: true

require 'open-uri'
require 'shellwords'
require 'bundler/gem_tasks'
require 'bundler/audit/task'
require 'rubocop/rake_task'

task default: %i[format lint]

desc 'Lint sources'
task lint: %i[lint:rubocop:autocorrect]

namespace :lint do
  RuboCop::RakeTask.new(:rubocop)
end

desc 'Format sources'
task format: %i[format:text]

namespace :format do
  desc 'Format text, YAML, and Markdown sources with prettier'
  task :text do
    sh 'npm run fmt'
  end
end

desc 'Format sources'
task fmt: %i[fmt:text]

namespace :fmt do
  desc 'Format text, YAML, and Markdown sources with prettier'
  task :text do
    sh 'npm run fmt'
  end
end

Bundler::Audit::Task.new

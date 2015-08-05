# Tasks
namespace :foreman_noenv do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanNoenv'
  Rake::TestTask.new(:foreman_noenv) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end
end

namespace :foreman_noenv do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_noenv) do |task|
        task.patterns = ["#{ForemanNoenv::Engine.root}/app/**/*.rb",
                         "#{ForemanNoenv::Engine.root}/lib/**/*.rb",
                         "#{ForemanNoenv::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_noenv'].invoke
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:foreman_noenv'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance do
    Rake::Task['test:foreman_noenv'].invoke
    Rake::Task['foreman_noenv:rubocop'].invoke
  end
end

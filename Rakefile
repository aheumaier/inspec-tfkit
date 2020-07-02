#------------------------------------------------------------------#
#                    Gem Packaging Tasks
#------------------------------------------------------------------#
begin
    require "bundler"
    Bundler::GemHelper.install_tasks
  rescue LoadError
    # no bundler available
  end
  
  #------------------------------------------------------------------#
  #                    Linter Tasks
  #------------------------------------------------------------------#
  
  begin
    require "chefstyle"
    require "rubocop/rake_task"
    RuboCop::RakeTask.new(:lint) do |task|
      task.options += ["--display-cop-names", "--no-color", "--parallel"]
    end
  
  rescue LoadError
    puts "rubocop is not available. Install the rubocop gem to run the lint tests."
  end
  
  #------------------------------------------------------------------#
  #                    Test Runner Tasks
  #------------------------------------------------------------------#
  require "rake/testtask"
  $VERBOSE = nil

  namespace(:test) do
    # This task template will make a task named 'test', and run
    # the tests that it finds.
    # Here, we split up the tests a bit, for the convenience
    # of the developer.
    desc "Run unit tests, to probe internal correctness"
    Rake::TestTask.new(:unit) do |task|
      task.libs << "test"
      task.pattern = "test/unit/*_spec.rb"
      task.warning = false
    end
  
    require "tmpdir"
    desc "Run InSpec integration tests for check for interface changes"
    Rake::TestTask.new(:inspec) do |task|
      task.libs << "test"
      tmp_dir = Dir.mktmpdir
      sh("bundle exec gem build inspec-tfkit.gemspec")
      # sh("inspec plugin install inspec-tfkit-*.gem --chef-license=accept")
      sh("wget -O #{tmp_dir}/inspec-aws.tar.gz -nc --tries=10 https://github.com/inspec/inspec-aws/archive/v1.5.1.tar.gz")
      sh("tar -C #{tmp_dir} -xzf #{tmp_dir}/inspec-aws.tar.gz")
      sh("inspec exec test/inspec --reporter=progress --input tmp_dir='#{tmp_dir}' resource_dir='#{tmp_dir}/inspec-aws-1.5.1'")
      FileUtils.remove_dir(tmp_dir)
      task.warning = false
    end
  
  end
  
  # Define a 'run all the tests' task.
  # You might think you'd want to depend on test:unit and test:functional,
  # but if you do that and either has a failure, the latter won't execute.
  desc "Run all tests"
  task test: %i{test:unit}
  
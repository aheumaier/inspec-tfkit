# Test helper file for plugins

# This file's job is to collect any libraries needed for testing, as well as provide
# any utilities to make testing a plugin easier.

# InSpec core provides a number of such libraries and facilities, in the file
# lib/plugins/shared/core_plugin_test_helper.rb . So, one job in this file is
# to locate and load that file.
require "inspec/../plugins/shared/core_plugin_test_helper"

# Also load the InSpec plugin system. We need this so we can unit-test the plugin
# classes, which will rely on the plugin system.
require "inspec/plugin/v2"

# You might want to put some debugging tools here.  We run tests to find bugs, after all.
require "byebug"

module TfkitFunctionalHelper

  def tfkit_project_root_path
    File.expand_path(File.join(__FILE__, "..", ".."))
  end

  def tfkit_fixtures_path
    File.join(tfkit_project_root_path, "test", "fixtures")
  end

  def run_check_and_json
    Proc.new do |tfkit_run_result, tmp_dir|

      # After running tfkit, run inspec check against
      # the generated profile
      check_cmd  = "check "
      check_cmd += " --format json "
      # check_cmd += File.join(tmp_dir, 'tfkit-test-profile')
      check_cmd += " tfkit-test-profile"

      check_result = run_inspec_process(check_cmd)
      begin
        tfkit_run_result.payload.check_json = JSON.parse(check_result.stdout)
      rescue JSON::ParserError => e
        tfkit_run_result.payload.check_json_error = e
      end
      tfkit_run_result.payload.check_result = check_result

      # Now run inspec json, which translates a profile into JSON
      export_cmd  = "json "
      # export_cmd += File.join(tmp_dir, 'tfkit-test-profile')
      export_cmd += "tfkit-test-profile"

      export_result = run_inspec_process(export_cmd)
      begin
        tfkit_run_result.payload.export_json = JSON.parse(export_result.stdout)
      rescue JSON::ParserError => e
        tfkit_run_result.payload.export_json_error = e
      end
      tfkit_run_result.payload.export_result = export_result
    end
  end

end

require "inspec/plugin/v2"

# The InspecPlugins namespace is where all plugins should declare themselves.
# The 'Inspec' capitalization is used throughout the InSpec source code 
module InspecPlugins
  module Tfkit
    class Plugin < ::Inspec.plugin(2)
      # Internal machine name of the plugin. InSpec will use this in errors, etc.
      plugin_name :'inspec-tfkit'

      cli_command :terraform do
        # Calling this hook doesn't mean tfkit is being executed - just that we
        # should be ready to do so. So, load the file that defines the functionality.
        # For example, InSpec will activate this hook when `inspec help` is
        # executed, so that this plugin's usage message will be included in the help.
        require "inspec-tfkit/terraform/cli_command"

        # Having loaded our functionality, return a class that will let the
        # CLI engine tap into it.
        InspecPlugins::Tfkit::Terraform::CliCommand
      end

      cli_command :tfkit do
        require "inspec-tfkit/tfkit_cli_command"
        InspecPlugins::Tfkit::CliCommand
      end

    end
  end
end

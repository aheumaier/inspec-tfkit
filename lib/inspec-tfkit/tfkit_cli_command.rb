# CloudFormation CLI command and options

require "inspec/plugin/v2"

require "inspec-tfkit/version"

module InspecPlugins
  module Tfkit
    class CliCommand < Inspec.plugin(2, :cli_command)
      subcommand_desc "tfkit", "Use 'inspec cloudformation' or 'inspec terraform'"

      desc "version", "Display version information"
      def version
        say("tfkit v#{InspecPlugins::Tfkit::VERSION}")
      end
    end
  end
end

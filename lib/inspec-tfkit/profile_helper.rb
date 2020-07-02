# -*- coding: utf-8 -*-
# renders the profile from the parsed files

require "yaml"

require "inspec-tfkit/platforms/aws_helper"
require "inspec-tfkit/platforms/azure_helper"
require "inspec-tfkit/platforms/gcp_helper"

module InspecPlugins
  module Tfkit
    class ProfileHelper
      # match the output of 'inspec init profile'
      # inspec/lib/plugins/inspec-init/lib/inspec-init/renderer.rb
      def self.render_profile(cli, options, source_file, controls, platform = nil)
        name = options[:name]
        overwrite_mode = options[:overwrite]

        #  --------------------------- InSpec Code Generator ---------------------------
        cli.headline("InSpec Tfkit Code Generator")

        full_destination_path = Pathname.new(Dir.pwd).join(name)

        if File.exist?(full_destination_path) && !overwrite_mode
          cli.plain_line "#{cli.emphasis(full_destination_path)} exists already, use --overwrite"
          cli.exit(1)
        end

        # ensure that full_destination_path directory is available
        FileUtils.mkdir_p(full_destination_path)

        # Creating new profile at /Users/mattray/ws/inspec-tfkit/FOO
        cli.plain_line "Creating new profile at #{cli.emphasis(full_destination_path)}"
        # * Creating file README.md
        render_readme_md(cli, name, source_file, platform)
        # * Creating directory controls
        cli.list_item "Creating directory #{cli.emphasis("controls")}"
        FileUtils.mkdir_p("#{name}/controls")
        # * Creating file controls/generated.rb
        render_controls_rb(cli, name, controls)
        # * Creating file inspec.yml
        render_inspec_yml(cli, name, source_file, options, platform)
        cli.plain_line
      end

      def self.render_readme_md(cli, name, source_file, platform)
        cli.list_item "Creating file #{cli.emphasis("README.md")}"
        f = File.new("#{name}/README.md", "w")
        f.puts("# #{name}")
        f.puts
        f.puts("This profile was generated by inspec-tfkit v#{Tfkit::VERSION} from the #{source_file} source file.")

        f.puts(InspecPlugins::Tfkit::Platforms::AwsHelper.readme) if platform.eql?("aws")
        f.puts(InspecPlugins::Tfkit::Platforms::AzureHelper.readme) if platform.eql?("azure")
        f.puts(InspecPlugins::Tfkit::Platforms::GcpHelper.readme) if platform.eql?("gcp")

        f.close
      end

      def self.render_inspec_yml(cli, name, source_file, options, platform)
        cli.list_item "Creating file #{cli.emphasis("inspec.yml")}"
        yml = {}
        yml["name"] = name
        yml["title"] = options[:title]
        yml["maintainer"] = options[:maintainer]
        yml["copyright"] = options[:copyright]
        yml["copyright_email"] = options[:email]
        yml["license"] = options[:license]
        yml["summary"] = options[:summary]
        yml["version"] = options[:version]
        yml["description"] = "Generated by inspec-tfkit v#{Tfkit::VERSION} from the #{source_file} source file."

        yml.merge!(InspecPlugins::Tfkit::Platforms::AwsHelper.inspec_yml) if platform.eql?("aws")
        yml.merge!(InspecPlugins::Tfkit::Platforms::AzureHelper.inspec_yml) if platform.eql?("azure")
        yml.merge!(InspecPlugins::Tfkit::Platforms::GcpHelper.inspec_yml) if platform.eql?("gcp")

        f = File.new("#{name}/inspec.yml", "w")
        f.write(yml.to_yaml)
        f.close
      end

      def self.render_controls_rb(cli, name, controls)
        cli.list_item "Creating file #{cli.emphasis("controls/generated.rb")}"
        f = File.new("#{name}/controls/generated.rb", "w")
        f.write(controls)
        f.close
      end
    end
  end
end
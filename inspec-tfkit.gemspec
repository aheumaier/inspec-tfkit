# coding: utf-8
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "inspec-tfkit/version"

Gem::Specification.new do |spec|
  spec.name        = "inspec-tfkit"
  spec.version     = InspecPlugins::Tfkit::VERSION
  spec.authors     = ["Andreas Heumaier"]
  spec.email       = ["anheumai@microsoft.com"]
  spec.summary     = "InSpec plugin to generate InSpec compliance profiles from Terraform and ARM Templates."
  spec.description = "InSpec plugin to generate InSpec profiles from Terraform and ARM Templates to ensure automatic compliance coverage."
  spec.homepage    = "https://github.com/aheumaier/inspec-tfkit"
  spec.license     = "Apache-2.0"

  spec.files = %w{
    README.md inspec-tfkit.gemspec Gemfile
  } + Dir.glob(
    "{bin,docs,examples,lib,tasks}/**/*", File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }

  spec.require_paths = ["lib"]

  spec.add_dependency "inspec", ">=3", "<5"
end

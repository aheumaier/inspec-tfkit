# frozen_string_literal: true

# helpers for working with InSpec-Azure profiles

require 'yaml'

module InspecPlugins::Tfkit::Platforms
  class AzureHelper
    # find the additional parameters
    AZURE_RESOURCE_QUALIFIERS = {
      'azurerm_network_interface' => %i[resource_group name]
    }.freeze

    # the iterators for the various resource types
    AZURE_RESOURCE_ITERATORS = {
    }.freeze

    AZURE_REMOVED_PROPERTIES = {
    }.freeze

    AZURE_TRANSLATED_RESOURCE_PROPERTIES = {
    }.freeze

    # readme content
    def self.tf_controls
      "\n"
    end

    # readme content
    def self.readme; end

    # inspec.yml boilerplate content from
    # inspec/lib/plugins/inspec-init/templates/profiles/azure/inspec.yml
    def self.inspec_yml
      yml = {}
      yml['inspec_version'] = '>= 2.2.7'
      yml['depends'] = [{
        'name' => 'inspec-azure',
        'url' => 'https://github.com/inspec/inspec-azure/archive/master.tar.gz'
      }]
      yml['supports'] = [{
        'platform' => 'azure'
      }]
      yml
    end
  end
end

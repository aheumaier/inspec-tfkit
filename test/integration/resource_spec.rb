# encoding: UTF-8
#
# Author:: Andreas Heumaier (<info@andreasheumaier.de>)
#
#
require "helper"

require "inspec-tfkit/inspec_helper"

module TfkitUnitTests
  class InSpecResources < Minitest::Test

    def known_resources
      {
        # List some resources we expect to heve
        # name => an expected property
        "aws_vpc" => "cidr_block",
        "directory" => "owner",
        "package" => "version",
      }
    end

    def test_it_should_list_resources
      known_resources.each_key do |resource_name|
        assert_includes(InspecPlugins::Tfkit::InspecHelper::RESOURCES, resource_name)
      end
    end

    def test_it_should_know_resource_properties
      known_resources.each do |resource_name, property|
        assert_includes(InspecPlugins::Tfkit::InspecHelper.resource_properties(resource_name), property)
      end
    end
  end
end

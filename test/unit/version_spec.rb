# encoding: UTF-8
#
# Author:: Andreas Heumaier (<info@andreasheumaier.de>)
#
#

require "minitest/autorun"
require "inspec-tfkit/version"

module TfkitUnitTests
  class Version < Minitest::Test
    def test_should_have_a_version_constant_defined
      assert_kind_of(String, InspecPlugins::Tfkit::VERSION)
    end
  end
end

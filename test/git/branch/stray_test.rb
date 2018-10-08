require 'test_helper'

module Git
  module Branch
    class StrayTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil ::Git::Branch::Stray::VERSION
      end

      def test_it_does_something_useful
        assert true # you better believe it!
      end
    end
  end
end

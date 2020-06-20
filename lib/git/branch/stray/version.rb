module Git
  module Branch
    module Stray
      NAME = 'git-branch--stray'.freeze
      VERSION = '2.0.0'.freeze

      def self.version
        "#{NAME} v#{VERSION}"
      end
    end
  end
end

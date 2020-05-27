module Git
  module Branch
    module Stray
      NAME = 'git-branch--stray'.freeze
      VERSION = '1.8.0'.freeze

      def self.version
        "#{NAME} v#{VERSION}"
      end
    end
  end
end

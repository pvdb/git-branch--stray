lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/branch/stray/version'
require 'git/branch/stray/gemspec'

Gem::Specification.new do |spec|
  spec.name          = Git::Branch::Stray::NAME
  spec.version       = Git::Branch::Stray::VERSION
  spec.authors       = ['Peter Vandenberk']
  spec.email         = ['pvandenberk@mac.com']

  spec.summary       = 'Delete stray local remote-tracking branches'
  spec.description   = 'Delete stray local remote-tracking branches'
  spec.homepage      = 'https://github.com/pvdb/git-branch--stray'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.post_install_message = Git::Branch::Stray::PIM

  spec.add_dependency 'consenter', '~> 1.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end

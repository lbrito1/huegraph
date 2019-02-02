
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "huegraph/version"

Gem::Specification.new do |spec|
  spec.name          = "huegraph"
  spec.version       = Huegraph::VERSION
  spec.authors       = ["Leonardo"]
  spec.email         = ["lbrito@gmail.com"]

  spec.summary       = %q{Print colored graphs and pick the hue.}
  spec.homepage      = "https://github.com/lbrito1/huegraph"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "curses", "~> 0.2.0"
  spec.add_dependency "chroma", "~> 1.2.7"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end

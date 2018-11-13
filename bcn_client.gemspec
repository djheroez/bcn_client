
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bcn_client/version"

Gem::Specification.new do |spec|
  spec.name          = "bcn_client"
  spec.version       = BcnClient::VERSION
  spec.authors       = ["Dennis Hernandez"]
  spec.email         = ["djheroez@gmail.com"]

  spec.summary       = %q{A gem to consume the BCN web service}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "http://127.0.0.1"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "http://127.0.0.1"
    spec.metadata["changelog_uri"] = "http://127.0.0.1"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir["README.md", "lib/**/*.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "savon", "= 2.12.0"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

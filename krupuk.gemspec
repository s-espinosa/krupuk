# frozen_string_literal: true

require_relative "lib/krupuk/version"

Gem::Specification.new do |spec|
  spec.name    = "krupuk"
  spec.version = Krupuk::VERSION
  spec.authors = ["Sal Espinosa"]
  spec.email   = ["sespinos@gmail.com"]

  spec.summary     = "Prawn-based layout engine for printing double-sided card sheets"
  spec.description = "Given a pack of cards (each with a front and a back), Krupuk lays them " \
                     "out on printable sheets with mirrored backs for duplex printing."
  spec.license  = "MIT"
  spec.homepage = "https://github.com/s-espinosa/krupuk"

  spec.metadata = {
    "homepage_uri"          => "https://github.com/s-espinosa/krupuk",
    "source_code_uri"       => "https://github.com/s-espinosa/krupuk/tree/main",
    "changelog_uri"         => "https://github.com/s-espinosa/krupuk/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir["lib/**/*", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0"

  spec.add_dependency "prawn", ">= 2.4", "< 3"
end

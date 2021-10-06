# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sidekiq/job_alert/version"

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-job_alert"
  spec.version       = Sidekiq::JobAlert::VERSION
  spec.authors       = ["feng.zhang"]
  spec.email         = ["cst.feng@gmail.com"]

  spec.summary       = 'Send alert to Slack if too many waiting jobs or dead jobs'
  spec.description   = 'Send alert to Slack if too many waiting jobs or dead jobs'
  spec.homepage      = "https://github.com/arthurbryant/sidekiq-job_alert"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "sidekiq", ">= 4.2.1", "< 6.3.0"
  spec.add_dependency "slack-notifier", "~> 2.3.2"
  spec.add_dependency "thor"
end

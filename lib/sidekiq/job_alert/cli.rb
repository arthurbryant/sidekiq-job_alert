require 'thor'
require 'sidekiq/job_alert'

module Sidekiq
  module JobAlert
    class CLI < Thor
      desc "alert config_path", "Send sidekiq queue alert to slack"
      option :config_path
      def alert
        Sidekiq::JobAlert::Notifier.new(options[:config_path]).call
      end
    end
  end
end

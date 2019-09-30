require 'thor'
require 'sidekiq/job_alert'

module Sidekiq
  module JobAlert
    class CLI < Thor
      desc "alert config", "Send sidekiq queue alert to slack"
      option :config
      def alert
        Sidekiq::JobAlert::Notifier.new(options[:config]).call
      end
    end
  end
end

# frozen_string_literal: true

require 'slack-notifier'
require 'sidekiq/job_alert/queue'

module Sidekiq
  module JobAlert
    class Notifier
      def initialize
        @slack_config ||= JSON.parse(::Rails.configuration.x.sidekiq_job_alert.to_json, object_class: OpenStruct)
      end

      def call
        # all jobs
        cnt = ::Sidekiq::JobAlert::Queue.all_job_cnt
        message = make_message(cnt)
        @slack_notifier.ping(message)
      end

      private

      def make_message(job_counter)
        format(
          @slack_config.alerting_sidekiq_all_waiting_jobs.message,
          env: ::Rails.env,
          job_counter: job_counter,
          url: @slack_config.alerting_sidekiq_all_waiting_jobs.url,
          )
      end

      def slack_notifier
        ::Slack::Notifier.new(
          @slack_config.webhook_url,
          username: @slack_config.username,
          channel: @slack_config.channel,
          )
      end
    end
  end
end

# frozen_string_literal: true

require 'slack-notifier'
require 'sidekiq/job_alert/queue'

module Sidekiq
  module JobAlert
    class Notifier
      def initialize(config)
        @slack_config = YAML.load_file(config)
        @message = ''
      end

      def call
        @message += make_dead_job_message
        @message += make_all_job_message('alert_total_waiting_jobs')
        keys = @slack_config[:alert_each_waiting_job].keys
        keys.delete(:message)
        keys.each do |key|
          @message += make_job_message('alert_each_waiting_job', key)
        end

        return if @message.empty?

        @message += @slack_config[:sidekiq_url]
        slack_notifier.ping(@message)
      end

      private

      def make_dead_job_message
        cnt = Sidekiq::JobAlert::Queue.dead_job_cnt
        cnt.positive? ? make_message('alert_dead_jobs', cnt) : ''
      end

      def make_all_job_message(type)
        cnt = Sidekiq::JobAlert::Queue.all_job_cnt
        limit = @slack_config[type.to_sym][:all][:limit].to_i
        cnt > limit ? make_message(type, cnt) : ''
      end

      def make_job_message(type, queue_name)
        cnt = Sidekiq::JobAlert::Queue.queue_job_cnt(queue_name)
        limit = @slack_config[type.to_sym][queue_name.to_sym][:limit].to_i
        cnt > limit ? make_message(type, cnt, queue_name.to_s) : ''
      end

      def make_message(type, job_counter, queue_name = nil)
        format(
          @slack_config[type.to_sym][:message],
          job_counter: job_counter,
          queue_name: queue_name
        )
      end

      def slack_notifier
        Slack::Notifier.new(
          @slack_config[:webhook_url],
          username: @slack_config[:username],
          channel: @slack_config[:channel]
        )
      end
    end
  end
end

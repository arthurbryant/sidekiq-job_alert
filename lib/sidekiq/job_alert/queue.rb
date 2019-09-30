# frozen_string_literal: true

require 'sidekiq/api'

module Sidekiq
  module JobAlert
    class Queue
      class << self
        def all_job_cnt
          return 0 if Sidekiq::Queue.all == []

          Sidekiq::Queue.all.sum(&:size)
        end

        def dead_job_cnt
          Sidekiq::DeadSet.new.size
        end

        def queue_job_cnt(queue_name)
          Sidekiq::Queue.new(queue_name).size
        end
      end
    end
  end
end

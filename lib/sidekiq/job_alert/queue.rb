# frozen_string_literal: true

require 'sidekiq'

module Sidekiq
  module JobAlert
    module Queue
      def all_job_cnt
        Sidekiq::Queue.all.sum(&:size)
      end

      module_function :all_job_cnt
    end
  end
end

#encoding:utf-8
class UserQueue < ActiveRecord::Base
  QUEUE_SIZE = 10
  DEFAULT_AMOUNT = 1
  DEFAULT_AMOUNT_UNIT = 1000 #厘
  QUEUE_TYPE = [IN=201, OUT=202, IDLE=203, NONE = 204]
  class << self
    def offer(account_name)
      UserQueue.transaction do
        handle_in_queue
        q = first_in_or_second_in(account_name)
        raise QueueError::AccountNameExistQueue unless q.is_in_queue
        q.queue_type = IN
        q.account_name = account_name
        q.is_in_queue = false
        q.save!
      end
    end

    def first_in_or_second_in(account_name)
      queue = UserQueue.where(account_name: account_name).first
      if queue.nil?
        queue = UserQueue.new
        queue.is_in_queue = true
        queue.is_acquisition_amount = false
        return queue
      end
      return queue
    end

    def handle_in_queue
      in_queues = UserQueue.where(queue_type: IN).order('updated_at asc')
      if in_queues.count >= QUEUE_SIZE - 1
        in_queues.update_all(:queue_type => OUT, :is_in_queue => false)
        handle_out_queue
      end
    end


    def handle_out_queue
      out_queue = UserQueue.where(queue_type: OUT).order('updated_at asc').first!
      raise StandardError unless out_queue.queue_type == OUT
      out_queue.queue_type = IDLE
      out_queue.is_acquisition_amount = true
      out_queue.save!
    end


    def out(queue, amount)
      raise StandardError unless queue.queue_type == IDLE
      raise StandardError unless queue.is_acquisition_amount == true
      queue.queue_type = NONE
      queue.acquisition_amount_count = queue.acquisition_amount_count + 1
      queue.last_acquisition_time = Time.now
      queue.last_acquisition_amount = amount
      queue.acquisition_amount_total = queue.acquisition_amount_total + amount
      queue.is_acquisition_amount = false
      queue.is_in_queue = true
      queue.save!
    end
  end


end

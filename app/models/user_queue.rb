class UserQueue < ActiveRecord::Base
  QUEUE_SIZE = 3
  DEFAULT_AMOUNT = 1000 #分

  #IS_IN_QUEUE_STATUS = [YES=101, NO=102]
  QUEUE_TYPE = [IN=201, OUT=202, IDLE=203]
  #attr_accessor :id, :account_name, :in_queue_num, :out_queue_num, :queue_type,
  #              :acquisition_amount_count, :last_acquisition_amount, :last_acquisition_time,
  #              :acquisition_amount_total, :is_in_queue, :is_acquisition_amount

  class << self
    def offer(account_name)
      current_queue_size = handle_in_queue
      q = first_in_or_second_in(account_name)
      raise ArgumentError unless q.is_in_queue
      q.queue_type = IN
      q.in_queue_num = current_queue_size+ 1
      q.account_name = account_name
      q.is_in_queue = false
      q.save!
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
      #1,2,3,4,5,6,7
      in_queues = UserQueue.where('queue_type = ? and in_queue_num !=?', IN, 0).order('in_queue_num asc')
      if in_queues.count == QUEUE_SIZE - 1
        #1,2,3,4,5,6,7
        out_queues = UserQueue.where('queue_type = ? and out_queue_num !=?', OUT, 0).order('out_queue_num asc')

        out_queue_num = out_queues.empty? ? 0 : out_queues.last.out_queue_num

        #in_queues.update_all(in_queue_num:0,)

        in_queues.each do |q|
          q.queue_type = OUT
          q.is_in_queue = false
          q.out_queue_num = out_queue_num + q.in_queue_num
          q.in_queue_num = 0
          q.save!
        end
        #first out
        handler_out_queue
      end

      return 0 if in_queues.empty?
      return in_queues.last.in_queue_num
    end

    def handler_out_queue
      out_queues = UserQueue.where('queue_type = ? and out_queue_num !=?', OUT, 0).order('out_queue_num asc')
      idle_queue_num_max = UserQueue.where('queue_type = ? and is_acquisition_amount = ?', UserQueue::IDLE, true).maximum(:idle_queue_num)
      queue = out_queues.first
      queue.in_queue_num = 0
      queue.out_queue_num = 0

      queue.queue_type = IDLE
      queue.idle_queue_num = (idle_queue_num_max || 0 )+ 1

      #queue.acquisition_amount_count = queue.acquisition_amount_count + 1
      #queue.last_acquisition_time = Time.now

      #queue.last_acquisition_amount = 100
      #queue.acquisition_amount_total = queue.acquisition_amount_total + 100
      #
      queue.is_acquisition_amount = true #是否可以领钱
      #queue.is_in_queue = true

      queue.save!

      #update out queue
      out_queues = UserQueue.where('queue_type = ? and out_queue_num !=?', OUT, 0).order('out_queue_num asc')
      out_queues.each do |q|
        q.out_queue_num = q.out_queue_num - 1
        q.save!
      end


    end
  end

  def aa(amount)
    self.queue_type = IN
    self.acquisition_amount_count = self.acquisition_amount_count + 1
    self.last_acquisition_time = Time.now
    self.last_acquisition_amount = amount
    self.acquisition_amount_total = self.acquisition_amount_total + amount
    self.is_acquisition_amount = false #是否可以领钱
    self.is_in_queue = true
    self.save!
  end


end

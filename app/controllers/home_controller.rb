class HomeController < ApplicationController

  def index
    @in_queues = UserQueue.where('queue_type = ? and in_queue_num !=?', UserQueue::IN, 0).order('in_queue_num asc')
    @out_queues = UserQueue.where('queue_type = ? and out_queue_num !=?', UserQueue::OUT, 0).order('out_queue_num asc')
    @acquisition_amount = UserQueue.where('acquisition_amount_count > ? and is_acquisition_amount = ?', 0, true)
  end


end

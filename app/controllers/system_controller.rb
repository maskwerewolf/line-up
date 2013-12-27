class SystemController < ApplicationController

  def index
    @acquisition_queue = UserQueue.where('queue_type = ? and is_acquisition_amount = ?', UserQueue::IDLE, true)
  end

end
class SystemController < ApplicationController

  def index
    @acquisition_queue = UserQueue.where('queue_type = ? and is_acquisition_amount = ?', UserQueue::IDLE, true)
  end

  def create
    q = UserQueue.find(params[:id])
    UserQueue.out(q, params[:amount].to_i)
    redirect_to '/system'
  end

end
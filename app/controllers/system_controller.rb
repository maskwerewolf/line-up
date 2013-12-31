class SystemController < ApplicationController

  def index
    @acquisition_queue = UserQueue.where('queue_type = ? and is_acquisition_amount = ?', UserQueue::IDLE, true).order('updated_at asc')
  end

  def create
    queue = UserQueue.find(params[:id])
    UserQueue.out(queue, params[:amount].to_i)
    redirect_to '/system'
  end

end
class HomeController < ApplicationController

  def index
    @in_queues = UserQueue.where(queue_type: UserQueue::IN).order('updated_at asc')
    @out_queues = UserQueue.where(queue_type: UserQueue::OUT).order('updated_at asc')
    @out_queues = @out_queues.paginate(:page => params[:page], :per_page => 2)
    @acquisition_amount = UserQueue.where('acquisition_amount_count > ? ', 0)
  end


end

class HomeController < ApplicationController

  def index
    @page_size = 18
    @page =  params[:page] || 0
    @in_queues = UserQueue.where(queue_type: UserQueue::IN).order('updated_at asc')
    @out_queues = UserQueue.where(queue_type: UserQueue::OUT).order('updated_at asc')

    @out_queues = @out_queues.paginate(:page => params[:page], :per_page => @page_size)
    @acquisition_amount = UserQueue.where('acquisition_amount_count > ? ', 0)
  end


end

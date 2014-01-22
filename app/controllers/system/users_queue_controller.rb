#encoding:utf-8
module System
  class UsersQueueController < SystemBaseController
    def index
      @page_size = 20
      @page =  params[:page] || 0
      @users_queue = UserQueue.where(queue_type: UserQueue::OUT).order('updated_at asc')
      @users_queue = @users_queue.paginate(:page => params[:page], :per_page => @page_size)
    end

    def destroy
      UserQueue.destroy(params[:id])
      redirect_to '/system/users_queue'
    end
  end
end
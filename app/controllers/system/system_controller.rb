#encoding:utf-8
module System
  class SystemController < SystemBaseController


    def index
      @acquisition_queue = UserQueue.where('queue_type = ? and is_acquisition_amount = ?', UserQueue::IDLE, true).order('updated_at asc')
    end

    def create
      RecodeLog.transaction do
        amount = params[:amount].to_f
        amount = amount * UserQueue::DEFAULT_AMOUNT_UNIT
        queue = UserQueue.find(params[:id])
        log = RecodeLog.new
        log.create_by = session[:name]
        log.account_name = queue.account_name
        log.last_acquisition_amount = queue.last_acquisition_amount
        log.amount = amount
        log.save!
        UserQueue.out(queue, amount)
      end

      redirect_to '/system'


    end

  end
end
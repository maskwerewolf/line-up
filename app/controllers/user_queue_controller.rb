class UserQueueController < ApplicationController
  def create
    unless captcha_valid? params[:captcha]
      redirect_to :root, :notice => Messages::CAPTCHA_ERROR
      return
    end
    begin
      UserQueue.offer(params[:account_name])
    rescue QueueError::AccountNameExistQueue => e
      redirect_to :root, :notice => e.message
      return
    rescue StandardError => e
      redirect_to :root, :notice => Messages::SYSTEM_ERROR
      logger.error "user in queue failed #{e.message}"
      return
    end
    redirect_to '/'
    #redirect_to :root
  end
end
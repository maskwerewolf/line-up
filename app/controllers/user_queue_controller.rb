class UserQueueController < ApplicationController
  def create
    unless captcha_valid? params[:captcha]
      redirect_to :root, :notice => Messages::CAPTCHA_ERROR
      return
    end

    begin
      account_name = params[:account_name]
      HttpUtil.auth_alipay_account(account_name)
      UserQueue.offer(account_name)
    rescue QueueError::AccountIsNil => e
      redirect_to :root, :notice => e.message
      return
    rescue QueueError::IsNotAliPayAccount => e
      redirect_to :root, :notice => e.message
      return
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
class UserQueueController < ApplicationController
  def create
    unless captcha_valid? params[:captcha]
      redirect_to :root, :notice => Messages::CAPTCHA_ERROR
      return
    end

    begin
      client_ip = request.remote_ip
      account_name = params[:account_name]
      UserQueue.offer(account_name,client_ip)
    rescue QueueError::FrequentlyAccess => e
      redirect_to :root, :notice => e.message
      logger.error "access ip stint #{client_ip}"
      return
    rescue QueueError::AccountIsNil => e
      redirect_to :root, :notice => e.message
      return
    rescue QueueError::IsNotAliPayAccount => e
      redirect_to :root, :notice => e.message
      logger.error "auth alipay account is wrong.the request ip is #{client_ip},account is #{account_name}"
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
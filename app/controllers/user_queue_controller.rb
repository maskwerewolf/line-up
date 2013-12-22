class UserQueueController < ApplicationController
  def create
    UserQueue.offer(params[:account_name])
    redirect_to '/'
    #redirect_to :root
  end
end
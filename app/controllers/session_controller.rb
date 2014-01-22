#encoding:utf-8
require 'digest'
class SessionController <ApplicationController
  def login
    render :'login/login'
  end

  def create
    destroy_session
    name = params[:name]
    password = params[:password]

    password  = Digest::MD5.hexdigest(password.encode('utf-8')).upcase
    unless password == '20091368A6F1E1B851122BECD8730FC0'
      redirect_to 'login'
      return
    end
    create_session name
    redirect_to '/system/queues'
  end

  def destroy
    destroy_session
    redirect_to '/login'
  end

  def create_session(name)
    session[:name] = name
  end

  def destroy_session
    session.clear
    # cookies.delete :name
  end




end
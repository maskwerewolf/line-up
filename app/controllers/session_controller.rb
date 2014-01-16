#encoding:utf-8
class SessionController <ApplicationController
  def login
    render :'login/login'
  end

  def create
    destroy_session
    name = params[:name]
    password = params[:password]
    create_session name
    redirect_to '/system'
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
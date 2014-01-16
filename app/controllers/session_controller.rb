#encoding:utf-8
class SessionController <ApplicationController
  def login
    render :'login/login'
  end

  def create
        p params[:name]
        p params[:password]
   redirect_to '/system'
  end

end
#encoding:utf-8
class SystemBaseController <ApplicationController
  before_filter :check_login

  def check_login
    if session[:name].blank?
      redirect_to '/login'
    end
  end


end
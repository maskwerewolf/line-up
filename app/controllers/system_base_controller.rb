#encoding:utf-8
class SystemBaseController <ApplicationController
  layout 'system/system_layout'
  before_filter :check_login
  def check_login
    if session[:name].blank?
      redirect_to '/login'
    end
  end


end
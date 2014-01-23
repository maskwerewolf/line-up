class ApplicationController < ActionController::Base
  include CookieManager
  after_filter :reset_last_captcha_code!
  protect_from_forgery
end

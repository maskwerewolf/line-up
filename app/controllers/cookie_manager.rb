module CookieManager
  Q_KEY ='+oTl1kSwAvqGD1tqBX8/6w==\n'
  def create_q
    cookies[Q_KEY.to_sym] = {:value =>Encrypt.encode('1'),:expires => 30.second.from_now}
  end

  def find_q(expires_time)
     value  =  cookies[Q_KEY.to_sym]
     return true if value.nil?
     value  = Encrypt.decode(value).to_i
  end


end

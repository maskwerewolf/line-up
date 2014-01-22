#encoding:utf-8
require 'httparty'
class HttpUtil
  def self.auth_alipay_account account_name
    raise QueueError::AccountIsNil if account_name.nil?
    url = "https://shenghuo.alipay.com/home/getUserStatus.json?account=#{account_name}"
    response = HTTParty.get(url)
    raise QueueError::IsNotAliPayAccount if JSON.parse(response.body)['userInfo']['realname'].nil?
    raise QueueError::IsNotAliPayAccount if JSON.parse(response.body)['userInfo']['accountStatCode'] == 'TRANSFER_USER_NOT_EXIST'
  end
  # true
  #{"sign"=>"false", "userInfo"=>{"accountStatCode"=>"", "userId"=>"2088302376710292", "isWhiteUser"=>"false", "account"=>"maskwerewolf@163.com", "realname"=>"*洪波"}, "msg"=>"", "stat"=>"ok"}
  #false
  #{"sign"=>"false", "userInfo"=>{"isWhiteUser"=>"false", "account"=>"maskwerewolf1@163.com", "accountStatCode"=>"TRANSFER_USER_NOT_EXIST"}, "msg"=>"此账户未注册。您可以继续转账，我们将短信通知他注册并完成收款。", "stat"=>"ok"}
end

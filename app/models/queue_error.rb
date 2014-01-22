#module Queue
class QueueError < StandardError
  #class QueueError < StandardError
  #end

  class AccountNameExistQueue < QueueError
    def initialize(msg = Messages::ACCOUNT_NAME_EXIST_QUEUE)
      super(msg)
    end
  end

  class IsNotAliPayAccount <QueueError
    def initialize(msg = Messages::IS_NOT_ALIPAY_ACCOUNT)
      super(msg)
    end
  end

  class AccountIsNil < QueueError
    def initialize(msg = Messages::ACCOUNT_IS_NIL)
      super(msg)
    end
  end
end

#module Queue
class QueueError < StandardError
  #class QueueError < StandardError
  #end

  class AccountNameExistQueue < QueueError
    def initialize(msg = Messages::ACCOUNT_NAME_EXIST_QUEUE)
      super(msg)
    end
  end
end

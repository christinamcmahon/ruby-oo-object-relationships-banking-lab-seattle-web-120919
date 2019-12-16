class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def execute_transaction
    if @sender.balance < @amount || !valid?
       @status = "rejected"
       return "Transaction rejected. Please check your account balance."
    elsif @status == "complete"
      return "Transfer already completed"
    else
      @sender.deposit(@amount * -1)
      @receiver.deposit(@amount)
      @status = "complete"
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(@amount)
      @receiver.deposit(@amount * -1)
      @status = "reversed"
    end
  end

  def valid?
    sender.valid? && receiver.valid?
  end
end

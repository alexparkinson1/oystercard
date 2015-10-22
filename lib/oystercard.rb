class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_TRAVEL_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Top up limit of £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient balance on oyster" if balance < MINIMUM_TRAVEL_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_TRAVEL_BALANCE)
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end
end

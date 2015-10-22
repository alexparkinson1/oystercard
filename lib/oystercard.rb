class Oystercard
  attr_reader :balance
  attr_reader :entry_station
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
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient balance on oyster" if balance < MINIMUM_TRAVEL_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_TRAVEL_BALANCE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

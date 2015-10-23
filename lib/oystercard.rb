class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_TRAVEL_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail "Top up limit of £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient balance on oyster" if balance < MINIMUM_TRAVEL_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_TRAVEL_BALANCE)
    @exit_station = exit_station
    @journeys = {:entry_station => entry_station, :exit_station => exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

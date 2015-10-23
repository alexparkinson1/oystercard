require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  def travelling
    subject.top_up(10)
    subject.touch_in(entry_station)
  end

  it 'is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can be touched in' do
    travelling
    expect(subject).to be_in_journey
  end

  it 'can be touched out' do
    travelling
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'cannot touch in if insufficient balance' do
    expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient balance on oyster"
  end

  it 'deducts money on touch out' do
    travelling
    expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_TRAVEL_BALANCE)
  end

  it 'remembers the entry station' do
    travelling
    expect(subject.entry_station).to eq entry_station
  end

  it 'remembers the exit station' do
    travelling
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'holds a journey log' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a journey' do
    travelling
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

  describe 'initialization' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if the maximum amount is exceeded' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error "Top up limit of £#{max_balance} exceeded"
    end
  end

end

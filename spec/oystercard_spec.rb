require 'oystercard'

describe Oystercard do

  it 'is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can be touched in' do
    subject.top_up(10)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can be touched out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts money when you touch in' do
      subject.top_up(10)
      expect{ subject.deduct 3}.to change{ subject.balance }.by -3
    end
  end
end

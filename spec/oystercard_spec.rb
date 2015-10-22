require 'oystercard'

describe Oystercard do
  describe 'initialization' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end
end

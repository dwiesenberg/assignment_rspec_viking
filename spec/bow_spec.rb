# RSPEC Viking -- Bow

require 'spec_helper'
require 'weapons/bow'

describe Bow do
  let(:bow){Bow.new(6)}

  describe'#arrows' do # arrow read method
    it 'should read (return) arrow count' do
      expect(bow.arrows).to eq(6)
    end

    let(:bow_default_arrows){Bow.new}
    it 'should start with 10 arrows by default' do
      expect(bow_default_arrows.arrows).to eq(10)
    end

    let(:bow_specified_arrows){Bow.new(12)}
    it 'starts with number of arrows specified on creation' do
      expect(bow_specified_arrows.arrows).to eq(12)
    end
  end

  describe '#use' do
    it 'reduces arrows by one' do
      allow(bow).to receive(:out_of_arrows?).and_return(false)
      allow(bow).to receive(:puts)
      bow.use
      expect(bow.arrows).to eq(5)
    end

    let(:bow_zero_arrows){Bow.new(0)}
    it 'throws error when arrow count is zero' do
      allow(bow_zero_arrows).to receive(:puts)
#      allow(bow_zero_arrows).to receive(:out_of_arrows?).and_return(true)
      expect{bow_zero_arrows.use}.to raise_error("Out of arrows")
    end
  end

end


 
    it 'throws an error if arrows were 0' do
      empty_bow = Bow.new(0)
      expect{empty_bow.use}.to raise_error("Out of arrows")





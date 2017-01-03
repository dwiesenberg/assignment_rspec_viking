# Warmup RSPEC Tests

require 'spec_helper'
require 'warmup.rb'

describe Warmup do
  let(:warmup){Warmup.new}
  describe '#gets_shout' do

    it 'receives #gets' do
      allow(warmup).to receive(:gets).and_return('abc')
      expect(warmup).to receive(:gets)
      allow(warmup).to receive(:puts) 
        # not really needed -- works without
      warmup.gets_shout
    end

    it 'receives #puts' do
      allow(warmup).to receive(:gets).and_return('abc')
      expect(warmup).to receive(:puts)
      warmup.gets_shout
    end

    it 'returns an upper case input string' do
      allow(warmup).to receive(:gets).and_return('abc')
      allow(warmup).to receive(:puts)
      expect(warmup.gets_shout).to eq('ABC')
    end

  end

  describe '#triple_size' do
    it 'triples size of input array' do
      array = double(:size => 4)
      expect(warmup.triple_size(array)).to eq(12)
    end
  end

  describe '#calls_some_methods' do
    let(:str){""}

    it 'raises error message if argument is empty' do
      expect(warmup.calls_some_methods(str)).to raise_error(RuntimeError)
    end
  end




# #######################


  describe '#calls_some_methods' do
    let(:str){"hello"}

    it 'calls #upcase! on the given string' do
      expect(str).to receive(:upcase!).and_return('HELLO')
      warmup.calls_some_methods(str)
    end

    it 'calls #reverse! on the given string' do
      expect(str).to receive(:reverse!).and_return('OLLEH')
      warmup.calls_some_methods(str)
    end

    it 'returns an unrelated string' do
      original = str.dup
#      allow(str).to receive(:upcase!).and_return('HELLO')
#      allow(str).to receive(:reverse!).and_return('OLLEH')
      expect(warmup.calls_some_methods(str)).to_not eq(original.upcase.reverse)
#      expect(warmup.calls_some_methods(str)).to eq("I am unrelated")
#      puts warmup.calls_some_methods(str)
    end


  end
end





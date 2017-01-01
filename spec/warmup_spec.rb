# Warmup RSPEC Tests

describe 'Warmup' do
  let (:warmup){warmup.new}
  describe 'gets_shout' do
    it 'receives "abc" from method gets' do
      expect (:warmup).to receive(:gets).and_return("abc")
      warmup.gets_shout
    end
  end
end





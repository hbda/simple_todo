describe FindGaps do
  subject { described_class.new.(m) }

  context '1' do
    let(:m) { [2, 3, 4, 6] }
    it { is_expected.to eq [1, 5] }
  end

  context '2' do
    let(:m) { [1, 2, 3, 4, 7] }
    it { is_expected.to eq [5, 6] }
  end

  context '3' do
    let(:m) { [3, 4, 5] }
    it { is_expected.to eq [1, 2] }
  end

  context '3' do
    let(:m) { [1, 3, 4, 5, 7] }
    it { is_expected.to eq [2, 6] }
  end
end

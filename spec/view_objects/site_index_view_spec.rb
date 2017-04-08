describe SiteIndexView do
  let(:view) { SiteIndexView.new(status) }

  describe '#tasks' do
    subject { view.tasks }

    let!(:active_task) { Task.create! name: 'task 1', status: :active, priority: 0 }
    let!(:completed_task) { Task.create! name: 'task 1', status: :completed, priority: 0 }

    context 'active' do
      let(:status) { 'active' }
      it { is_expected.to eq [active_task] }
    end

    context 'completed' do
      let(:status) { 'completed' }
      it { is_expected.to eq [completed_task] }
    end
  end

  describe '#active?' do
    subject { view.active? }

    context 'active' do
      let(:status) { 'active' }
      it { is_expected.to eq true }
    end

    context 'completed' do
      let(:status) { 'completed' }
      it { is_expected.to eq false }
    end
  end

  describe '#completed?' do
    subject { view.completed? }

    context 'active' do
      let(:status) { 'active' }
      it { is_expected.to eq false }
    end

    context 'completed' do
      let(:status) { 'completed' }
      it { is_expected.to eq true }
    end
  end
end

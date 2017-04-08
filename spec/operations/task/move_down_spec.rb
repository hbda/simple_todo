describe Task::MoveDown do
  subject(:result) { described_class.new.(task.id) }
  let(:task) { Task.create! name: 'name', priority: priority }
  let!(:another_task) { Task.create! name: 'name 2', priority: 10 }

  context 'priority is bottom' do
    let(:priority) { another_task.priority + 1 }
    it do
      expect(result).to be_success
      expect(result.value.priority).to eq priority
    end
  end

  context 'priority is not bottom' do
    let(:priority) { another_task.priority - 2 }
    it do
      expect(result).to be_success
      expect(result.value.priority).to eq another_task.priority
      expect(another_task.reload.priority).to eq priority
    end
  end

  context 'priority is 0' do
    let(:priority) { 0 }
    it do
      expect(result).to be_success
      expect(result.value.priority).to eq another_task.priority
      expect(another_task.reload.priority).to eq priority
    end
  end
end

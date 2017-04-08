describe Task::Destroy do
  subject(:result) { described_class.new.(task.id) }
  let(:task) { Task.create! name: 'Task 1', priority: 0 }

  it do
    expect(result).to be_succes
    expect(result.value).to be_destroyed
  end
end

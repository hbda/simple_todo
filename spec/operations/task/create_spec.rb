describe Task::Create do
  subject(:result) { described_class.new.(params) }

  context 'valid params' do
    let(:params) { { name: 'Task name', description: 'description' } }

    context 'first task' do
      it do
        expect(result).to be_success
        expect(result.value).to have_attributes(
          name: params[:name],
          description: params[:description],
          priority: 0
        )
      end
    end

    context 'second task' do
      let!(:previous_task) { Task.create! name: 'Previous', priority: 123 }
      it do
        expect(result).to be_success
        expect(result.value).to have_attributes(
          name: params[:name],
          description: params[:description],
          priority: previous_task.priority + 1
        )
      end
    end
  end

  context 'invalid params' do
    let(:params) { { description: 'description' } }
    it do
      expect(result).to be_failure
      expect(result.value).to be_kind_of Task
      expect(result.value.errors).to have(1).items
    end
  end
end

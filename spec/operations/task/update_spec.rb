describe Task::Update do
  subject(:result) { described_class.new.(task.id, params) }
  let(:task) do
    Task.create!(
      name: 'old name',
      description: 'old description',
      priority: 0
    )
  end

  context 'valid params' do
    let(:params) { { name: 'new name', description: 'new description' } }

    it do
      expect(result).to be_success
      expect(result.value).to have_attributes(
        name: params[:name],
        description: params[:description]
      )
    end
  end

  context 'invalid params' do
    let(:params) { { name: '', description: 'description' } }
    it do
      expect(result).to be_failure
      expect(result.value.errors).to have(1).items
    end
  end
end

describe TasksController do
  describe '#index' do
    before { get :index }
    it { expect(response).to have_http_status(:success) }
  end

  describe '#new' do
    before { get :new }
    it { expect(response).to have_http_status(:success) }
  end

  describe '#create' do
    let(:task) { Task.create! name: 'Task 1', priority: 0 }
    let(:params) { { name: 'Task 1' } }
    let(:operation) { double call: operation_result }

    before do
      allow(Task::Create).to receive(:new).and_return(operation)
      post :create, task: params
    end

    context 'operation success' do
      let(:operation_result) { Dry::Monads::Right(task) }
      it do
        expect(operation).to have_received(:call).with(params)
        expect(response).to redirect_to tasks_url
      end
    end

    context 'operation failure' do
      let(:operation_result) { Dry::Monads::Left(task) }
      it do
        expect(operation).to have_received(:call).with(params)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    let(:task) { Task.create! name: 'Task 1', priority: 0 }
    before { get :show, id: task.id }

    it { expect(response).to have_http_status(:success) }
  end

  describe '#edit' do
    let(:task) { Task.create! name: 'Task 1', priority: 0 }
    before { get :edit, id: task.id }

    it { expect(response).to have_http_status(:success) }
  end

  describe '#update' do
    let(:task) { Task.create! name: 'Task 1', priority: 0 }
    let(:params) { { name: 'Task new' } }
    let(:operation) { double call: operation_result }

    before do
      allow(Task::Update).to receive(:new).and_return(operation)
      patch :update, id: task.id, task: params
    end

    context 'operation success' do
      let(:operation_result) { Dry::Monads::Right(task) }
      it do
        expect(operation).to have_received(:call).with(task.id.to_s, params)
        expect(response).to redirect_to tasks_url
      end
    end

    context 'operation failure' do
      let(:operation_result) { Dry::Monads::Left(task) }
      it do
        expect(operation).to have_received(:call).with(task.id.to_s, params)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#destroy' do
    let(:task) { Task.create! name: 'Task 1', priority: 0 }
    let(:operation) { double call: operation_result }

    before do
      allow(Task::Destroy).to receive(:new).and_return(operation)
      delete :destroy, id: task.id
    end

    context 'operation success' do
      let(:operation_result) { Dry::Monads::Right(task) }
      it do
        expect(operation).to have_received(:call).with(task.id.to_s)
        expect(response).to redirect_to tasks_url
      end
    end

    context 'operation failure' do
      let(:operation_result) { Dry::Monads::Left(task) }
      it do
        expect(operation).to have_received(:call).with(task.id.to_s)
        expect(response).to redirect_to tasks_url
        expect(flash[:alert]).to be_present
      end
    end
  end
end

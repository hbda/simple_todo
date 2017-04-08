class TasksController < ApplicationController
  def index
    @view = SiteIndexView.new(params[:status])
  end

  def new
    @task = Task.new
  end

  def create
    result = Task::Create.new.(permitted_params.to_h)

    if result.success?
      redirect_to tasks_url
    else
      @task = result.value
      render :new
    end
  end

  def show
    @task = Task.find params[:id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    result = Task::Update.new.(params[:id], permitted_params.to_h)

    if result.success?
      redirect_to tasks_url
    else
      @task = result.value
      render :edit
    end
  end

  def destroy
    result = Task::Destroy.new.(params[:id])

    if result.success?
      redirect_to tasks_url
    else
      redirect_to tasks_url, alert: 'Не удалось удалить задачу'
    end
  end

  def change_priority
    result =
      if params[:direction] == 'up'
        Task::MoveUp.new.(params[:task_id])
      else
        Task::MoveDown.new.(params[:task_id])
      end

    if result.success?
      redirect_to tasks_url
    else
      redirect_to tasks_url, alert: 'Не удалось изменить приоритет задачи'
    end
  end

  private

  def permitted_params
    params.require(:task).permit(:name, :description, :status)
  end
end

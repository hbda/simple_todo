class Task::Update < OperationBase
  def call id, params
    task = Task.find id
    task.update params

    if task.valid?
      Right(task)
    else
      Left(task)
    end
  end
end

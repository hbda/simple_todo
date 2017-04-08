class Task::Destroy < OperationBase
  def call id
    task = Task.find id
    task.destroy

    if task.destroyed?
      Right(task)
    else
      Left(task)
    end
  end
end

class Task::Create < OperationBase
  def call params
    task = Task.create params.merge(priority: priority)

    if task.valid?
      Right(task)
    else
      Left(task)
    end
  end

  private

  def priority
    max_priority = Task.maximum(:priority)
    max_priority.nil? ? 0 : max_priority + 1
  end
end

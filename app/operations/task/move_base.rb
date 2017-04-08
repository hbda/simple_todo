class Task::MoveBase < OperationBase
  def call id
    task = Task.find id
    previous_task = find_previous_task task
    return Right(task) if previous_task.nil?

    swap_priorities task, previous_task

    Right(task)
  rescue ActiveRecord::ActiveRecordError => ex
    Left(task)
  end

  private

  def swap_priorities task1, task2
    task1_priority = task1.priority

    Task.transaction do
      task1.update! priority: task2.priority
      task2.update! priority: task1_priority
    end
  end

  def find_previous_task _task
    raise NotImplementedError
  end
end

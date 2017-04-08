class Task::MoveDown < Task::MoveBase
  private

  def find_previous_task task
    Task
      .active
      .where('priority > ?', task.priority)
      .order(priority: :asc)
      .first
  end
end

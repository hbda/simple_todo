class Task::MoveUp < Task::MoveBase
  private

  def find_previous_task task
    Task
      .active
      .where('priority < ?', task.priority)
      .order(priority: :desc)
      .first
  end
end

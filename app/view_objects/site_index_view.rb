class SiteIndexView
  attr_accessor :status

  def initialize status = 'active'
    @status = status || 'active'
  end

  def tasks
    if status == 'active'
      active_list
    else
      completed_list
    end
  end

  def active?
    status == 'active'
  end

  def completed?
    status == 'completed'
  end

  private

  def active_list
    Task.active.order(:priority)
  end

  def completed_list
    Task.completed.order(updated_at: :desc)
  end
end

require 'date'

class Task < ActiveRecord::Base
  belongs_to :task_list

  validates :title, presence: true

  after_initialize :set_defaults

  def complete!
    self.status = "complete"
  end

  def incomplete!
    self.status = "incomplete"
  end

  def user
    self.task_list.user
  end

  private

  def set_defaults
    self.status      = "incomplete" unless self.status
    self.due_date    = Date.today unless self.due_date
    self.description = "" unless self.description
  end
end

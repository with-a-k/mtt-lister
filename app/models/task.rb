require 'date'

class Task < ActiveRecord::Base
  belongs_to :task_list

  validates :title, presence: true

  after_initialize :set_defaults

  scope :incomplete, -> { where(status: 'incomplete') }
  scope :complete, -> { where(status: 'complete') }

  def complete!
    self.update!(status: "complete")
  end

  def incomplete!
    self.update!(status: "incomplete")
  end

  def user
    self.task_list.user
  end

  private

  def set_defaults
    self.status      = "incomplete" unless self.status
    self.due_date    = Date.today unless self.due_date
    self.description = "" unless self.description
    self.user_id     = self.task_list.user_id if self.task_list
  end
end

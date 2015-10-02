class TaskList < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates :title, presence: true

  after_initialize :set_defaults

  def archive!
    self.archived = true
  end

  private

  def set_defaults
    self.archived = false
  end
end

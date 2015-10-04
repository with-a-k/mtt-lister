class TaskList < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates :title, presence: true

  after_initialize :set_defaults

  scope :belonging_to_user, ->(user) { where('user_id = ?', user.id) }
  scope :unarchived, -> { where(archived: false) }

  def archive!
    self.archived = true
  end

  private

  def set_defaults
    self.archived = false unless self.archived
  end
end

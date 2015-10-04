class TaskList < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates :title, presence: true

  after_initialize :set_defaults

  scope :belonging_to_user, ->(id) { where('user_id = ?', id) }
  scope :unarchived, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def archive!
    self.archived = true
  end

  private

  def set_defaults
    self.archived = false unless self.archived
  end
end

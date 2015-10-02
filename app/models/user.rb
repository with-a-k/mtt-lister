class User < ActiveRecord::Base
  has_secure_password

  has_many :task_lists
  has_many :tasks, through: :task_lists

  validates :name,            presence: true
  validates :password_digest, presence: true
end

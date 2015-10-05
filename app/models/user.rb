require 'digest/sha1'

class User < ActiveRecord::Base
  has_secure_password

  has_many :task_lists
  has_many :tasks, through: :task_lists

  validates :name,            presence: true
  validates :password_digest, presence: true

  def token
    Digest::SHA1.hexdigest "#{self.name} #{self.password_digest}"
  end
end

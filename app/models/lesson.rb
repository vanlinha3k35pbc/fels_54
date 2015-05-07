class Lesson < ActiveRecord::Base
  include ActivityLogs

  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results

  after_create :learn_log

  def learn_log
    log_activity user.id, "learn", id
  end
end

class Relationship < ActiveRecord::Base
  include ActivityLogs

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :follow_log
  before_destroy :unfollow_log

  def follow_log
    log_activity follower_id, "follow", followed_id
  end

  def unfollow_log
    log_activity follower_id, "unfollow", followed_id
  end
end

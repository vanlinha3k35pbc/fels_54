module ActivityLogs
  def log_activity user_id, action, target_id
    Activity.create! user_id: user_id, action: action, target_id: target_id
  end
end

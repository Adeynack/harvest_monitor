module ApplicationHelper
  def human_hours_minutes(duration_in_hours)
    hours, decimal_minutes = duration_in_hours.divmod(1)
    minutes = (60 * decimal_minutes).round
    [hours, format("%02d", minutes)].join(":")
  end
end

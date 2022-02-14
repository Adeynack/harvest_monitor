module ApplicationHelper
  def human_hours_minutes(duration_in_hours)
    div_mod = duration_in_hours.divmod(duration_in_hours <=> 0)
    div_mod.map!(&:-@) if duration_in_hours.negative?
    hours, decimal_minutes = div_mod
    minutes = (60 * decimal_minutes).round
    [hours, format("%02d", minutes)].join(":")
  end
end

module ApplicationHelper
  def human_hours_minutes(duration_in_hours)
    div_mod = duration_in_hours.divmod(duration_in_hours.negative? ? -1 : 1)
    div_mod.map!(&:-@) if duration_in_hours.negative?
    hours, decimal_minutes = div_mod
    minutes = (60 * decimal_minutes).round

    hours_part = "#{'-' if duration_in_hours.negative?}#{hours.abs}"
    minutes_part = format("%02d", minutes)

    [hours_part, minutes_part].join(":")
  end
end

class MonitorController < ApplicationController
  def index
    @worked_hours_per_day = 7.5
    @billable_hours_per_day = 6
    @worked_days = params[:worked_days] || 5

    week_of_dt = params[:week_of].presence&.then { |w| DateTime.parse(d) } || DateTime.current
    @first_day = week_of_dt.beginning_of_week.to_date
    @last_day = week_of_dt.end_of_week.to_date
    @week_of = week_of_dt.to_date

    harvest = HarvestApi.new
    @user = Rails.cache.fetch([:harvest, :me, harvest.user_id], expires_in: 10.minutes) { harvest.me }
    entries_for_this_week = Rails.cache.fetch([:harvest, :time_entries, harvest.user_id], expires_in: 5.minutes) do
      harvest.time_entries(from: @first_day, to: @last_day)
    end

    @daily_summaries = entries_for_this_week.group_by(&:spent_date).transform_values do |entries|
      {
        total_worked: entries.map(&:hours).sum,
        total_billable: entries.filter(&:billable).map(&:hours).sum
      }
    end

    @week_summary = {
      total_worked: entries_for_this_week.map(&:hours).sum,
      total_billable: entries_for_this_week.filter(&:billable).map(&:hours).sum
    }
  end
end
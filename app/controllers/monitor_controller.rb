# frozen_string_literal: true

class MonitorController < ApplicationController
  def index
    @worked_hours_per_day = 7.5
    @billable_hours_per_day = 6
    @worked_days = params[:worked_days]&.to_i || 5

    week_of_dt = params[:week_of].presence&.then { |d| DateTime.parse(d) } || DateTime.current
    @first_day = week_of_dt.beginning_of_week.to_date
    @last_day = week_of_dt.end_of_week.to_date
    @week_of = week_of_dt.to_date
    @worked_days_so_far = [@worked_days, DateTime.current.mjd - @first_day.mjd + 1].min

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

    @estimated_end_of_day = DateTime.current + (@worked_hours_per_day - @daily_summaries.dig(Date.current, :total_worked).to_d).hours

    @reload_seconds = params.fetch(:reload_seconds, "60").to_i

    @full_url = root_path(params: {
      worked_days: @worked_days,
      week_of: @first_day,
      reload_seconds: @reload_seconds
    })
  end
end

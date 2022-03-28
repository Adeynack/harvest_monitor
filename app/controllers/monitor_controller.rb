# frozen_string_literal: true

class MonitorController < ApplicationController
  def show
    @worked_hours_per_day = 7.5
    @billable_hours_per_day = 6

    @sprint_of = params[:sprint_of] || Date.current
    @sprint = Sprint.find_for_date(@sprint_of)
    return unless @sprint

    @first_day = @sprint.during.min
    @last_day = @sprint.during.max

    @worked_days = @sprint.worked_days
    @worked_days_count = @worked_days.size
    @worked_days_so_far = @worked_days.count { |d| !d.future? }

    harvest = HarvestApi.new
    @user = Rails.cache.fetch([:harvest, :me, harvest.user_id], expires_in: 10.minutes) { harvest.me }
    entries_for_this_week = Rails.cache.fetch([:harvest, :time_entries, harvest.user_id], expires_in: 5.minutes) do
      harvest.time_entries(from: @sprint.during.min, to: @sprint.during.max)
    end

    @daily_summaries = entries_for_this_week.group_by(&:spent_date).transform_values do |entries|
      {
        total_worked: entries.map(&:hours).sum,
        total_billable: entries.filter(&:billable).map(&:hours).sum
      }
    end

    @sprint_summary = {
      total_worked: entries_for_this_week.map(&:hours).sum,
      total_billable: entries_for_this_week.filter(&:billable).map(&:hours).sum
    }

    @estimated_end_of_day = DateTime.current + (@worked_hours_per_day - @daily_summaries.dig(Date.current, :total_worked).to_d).hours

    @seconds_to_reload = params.fetch(:seconds_to_reload, "60").to_i

    @full_url = root_path(params: {
      sprint_of: @sprint.during.min,
      seconds_to_reload: @seconds_to_reload
    })
  end
end

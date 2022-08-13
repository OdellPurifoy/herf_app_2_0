# frozen_string_literal: true

module ApplicationHelper
  # def flash_class(level)
  #   bulma_alert_class = {
  #     'success' => 'notification is-primary is-light',
  #     'error' => 'notification is-danger is-light',
  #     'notice' => 'notification is-primary is-light',
  #     'alert' => 'notification is-danger is-light',
  #     'warn' => 'notification is-warning is-light'
  #   }
  #   bulma_alert_class[level]
  # end

  def time_select_options(step=15)
    tod = Tod::TimeOfDay.new 0
    times = []
    96.times do
      times << [tod.strftime("%l:%M %P"), tod]
      tod = tod + step.minutes
    end

    times
  end
end

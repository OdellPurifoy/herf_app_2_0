# frozen_string_literal: true

class CalendarUrlSerivce
  def initialize(event)
    @event = event
  end

  def calendar
    AddToCalendar::URLs.new(
      start_datetime: Time.new(@event.event_date.year, @event.event_date.month, @event.event_date.day),
      title: @event.name.to_s,
      timezone: 'America/New_York',
      location: "#{@event.lounge.address_street_1}, #{@event.lounge.city}, #{@event.lounge.state}, #{@event.lounge.zip_code}",
      description: @event.event_description.to_s
    )
  end
end

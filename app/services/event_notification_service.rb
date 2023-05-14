# frozen_string_literal: true

class EventNotificationService
  def initialize(obj)
    @obj = obj
  end

  def new_notification
    new_event_notification_for_members
    new_event_text_notification_for_members
  end

  def update_notification
    updated_event_notification_for_members
    updated_event_text_for_members
  end

  def cancellation_notification
    cancelled_event_notification_for_members
    cancelled_event_text_for_members
  end

  private

  def new_event_notification_for_members
    return if @obj.lounge.memberships.active.empty?

    @obj.lounge.memberships.active.each do |membership|
      NotifyFollowersMailer.with(membership: membership, event: @obj).notify_members.deliver_now
    end
  end

  def new_event_text_notification_for_members
    @members_phone_numbers = @obj.lounge.memberships.active.pluck(:phone_number).compact
    @message = %(You have been invited to #{@obj.name},
      hosted by #{@obj.lounge.name}!
      Here are the details:
      Event: #{@obj.name}
      Date: #{@obj.event_date.strftime('%b %e, %Y')}
      Start Time: #{@obj.start_time.strftime('%l:%M %P')}
      End Time: #{@obj.end_time.strftime('%l:%M %P')}
      Location: #{@obj.lounge.address_street_1}, #{@obj.lounge.city}, #{@obj.lounge.state}, #{@obj.lounge.zip_code}
      Phone: #{@obj.lounge.phone})

    @members_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, @message, @obj)
    end
  end

  def updated_event_notification_for_members
    return if @obj.lounge.memberships.active.empty?

    @obj.lounge.memberships.active.each do |membership|
      UpdatedEventNotificationMailer.with(membership: membership, event: @obj).update_notify_members.deliver_now
    end
  end

  def updated_event_text_for_members
    @members_phone_numbers = @obj.lounge.memberships.active.pluck(:phone_number).compact
    @message = %(The #{@obj.name} event, hosted by #{@obj.lounge.name} has been updated.
      Here are the latest details:
      Event: #{@obj.name}
      Date: #{@obj.event_date.strftime('%b %e, %Y')}
      Start Time: #{@obj.start_time.strftime('%l:%M %P')}
      End Time: #{@obj.end_time.strftime('%l:%M %P')}
      Location: #{@obj.lounge.address_street_1}, #{@obj.lounge.city}, #{@obj.lounge.state}, #{@obj.lounge.zip_code}
      Phone: #{@obj.lounge.phone})

    @members_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, @message, @obj)
    end
  end

  def cancelled_event_notification_for_members
    return if @obj.lounge.memberships.active.empty?

    @obj.lounge.memberships.active.each do |membership|
      CancelledEventNotificationMailer.with(membership: membership, event: @obj).cancel_notify_members.deliver_now
    end
  end

  def cancelled_event_text_for_members
    @members_phone_numbers = @obj.lounge.memberships.active.pluck(:phone_number).compact
    @message = %(The #{@obj.name} event, hosted by #{@obj.lounge.name} has been cancelled.
      Please contact #{@obj.lounge.name} at: #{@obj.lounge.phone} for additional information.
      Thank you.)

    @members_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, @message, @obj)
    end
  end
end

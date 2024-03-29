# frozen_string_literal: true

desc 'This task is called by the Heroku scheduler add-on'
task send_text_reminders: :environment do
  Event.send_text_reminders
end

task send_email_reminders: :environment do
  Event.send_reminder_email
end
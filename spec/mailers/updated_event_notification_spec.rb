# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdatedEventNotificationMailer, type: :mailer do
  describe 'notify_followers' do
    let(:mail) { UpdatedEventNotificationMailer.update_followers }

    it 'renders the headers' do
      expect(mail.subject).to eq('Upcoming event has been updated')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end

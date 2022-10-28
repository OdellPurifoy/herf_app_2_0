require "rails_helper"

RSpec.describe CancelledEventNotificationMailer, type: :mailer do
  describe "cancel_notify_followers" do
    let(:mail) { CancelledEventNotificationMailer.cancel_notify_followers }

    it "renders the headers" do
      expect(mail.subject).to eq("Cancel notify followers")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

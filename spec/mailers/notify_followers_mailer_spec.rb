require "rails_helper"

RSpec.describe NotifyFollowersMailer, type: :mailer do
  describe "notify_followers" do
    let(:mail) { NotifyFollowersMailer.notify_followers }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify followers")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

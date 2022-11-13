require "rails_helper"

RSpec.describe CancelledSpecialOfferMailer, type: :mailer do
  describe "notify_followers" do
    let(:mail) { CancelledSpecialOfferMailer.notify_followers }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify followers")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "notify_members" do
    let(:mail) { CancelledSpecialOfferMailer.notify_members }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify members")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

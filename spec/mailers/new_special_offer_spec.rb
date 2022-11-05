require "rails_helper"

RSpec.describe NewSpecialOfferMailer, type: :mailer do
  describe "notify_followers_and_members" do
    let(:mail) { NewSpecialOfferMailer.notify_followers_and_members }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify followers and members")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "notify_members_only" do
    let(:mail) { NewSpecialOfferMailer.notify_members_only }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify members only")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

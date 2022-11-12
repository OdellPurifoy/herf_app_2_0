require "rails_helper"

RSpec.describe UpdateSpecialOfferMailer, type: :mailer do
  describe "notify_followes" do
    let(:mail) { UpdateSpecialOfferMailer.notify_followes }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify followes")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "notify_members" do
    let(:mail) { UpdateSpecialOfferMailer.notify_members }

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

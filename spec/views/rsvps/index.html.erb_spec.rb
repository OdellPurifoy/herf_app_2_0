require 'rails_helper'

RSpec.describe "rsvps/index", type: :view do
  before(:each) do
    assign(:rsvps, [
      Rsvp.create!(
        first_name: "First Name",
        last_name: "Last Name",
        phone_number: "Phone Number",
        email: "Email",
        user: nil,
        event: nil
      ),
      Rsvp.create!(
        first_name: "First Name",
        last_name: "Last Name",
        phone_number: "Phone Number",
        email: "Email",
        user: nil,
        event: nil
      )
    ])
  end

  it "renders a list of rsvps" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Phone Number".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end

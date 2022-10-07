require 'rails_helper'

RSpec.describe "lounge_memberships/index", type: :view do
  before(:each) do
    assign(:lounge_memberships, [
      LoungeMembership.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        phone_number: "Phone Number",
        lounge: nil
      ),
      LoungeMembership.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        phone_number: "Phone Number",
        lounge: nil
      )
    ])
  end

  it "renders a list of lounge_memberships" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Phone Number".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end

require 'rails_helper'

RSpec.describe "memberships/show", type: :view do
  before(:each) do
    @membership = assign(:membership, Membership.create!(
      first_name: "First Name",
      last_name: "Last Name",
      email: "Email",
      phone_number: "Phone Number",
      lounge: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(//)
  end
end

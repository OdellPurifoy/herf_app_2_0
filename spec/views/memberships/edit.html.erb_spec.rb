require 'rails_helper'

RSpec.describe "memberships/edit", type: :view do
  before(:each) do
    @membership = assign(:membership, Membership.create!(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
      phone_number: "MyString",
      lounge: nil
    ))
  end

  it "renders the edit membership form" do
    render

    assert_select "form[action=?][method=?]", membership_path(@membership), "post" do

      assert_select "input[name=?]", "membership[first_name]"

      assert_select "input[name=?]", "membership[last_name]"

      assert_select "input[name=?]", "membership[email]"

      assert_select "input[name=?]", "membership[phone_number]"

      assert_select "input[name=?]", "membership[lounge_id]"
    end
  end
end

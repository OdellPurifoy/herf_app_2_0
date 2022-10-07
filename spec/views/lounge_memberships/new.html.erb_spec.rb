require 'rails_helper'

RSpec.describe "lounge_memberships/new", type: :view do
  before(:each) do
    assign(:lounge_membership, LoungeMembership.new(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
      phone_number: "MyString",
      lounge: nil
    ))
  end

  it "renders new lounge_membership form" do
    render

    assert_select "form[action=?][method=?]", lounge_memberships_path, "post" do

      assert_select "input[name=?]", "lounge_membership[first_name]"

      assert_select "input[name=?]", "lounge_membership[last_name]"

      assert_select "input[name=?]", "lounge_membership[email]"

      assert_select "input[name=?]", "lounge_membership[phone_number]"

      assert_select "input[name=?]", "lounge_membership[lounge_id]"
    end
  end
end

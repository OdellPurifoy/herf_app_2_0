require 'rails_helper'

RSpec.describe "memberships/new", type: :view do
  before(:each) do
    assign(:membership, Membership.new(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
      phone_number: "MyString",
      lounge: nil
    ))
  end

  it "renders new membership form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do

      assert_select "input[name=?]", "membership[first_name]"

      assert_select "input[name=?]", "membership[last_name]"

      assert_select "input[name=?]", "membership[email]"

      assert_select "input[name=?]", "membership[phone_number]"

      assert_select "input[name=?]", "membership[lounge_id]"
    end
  end
end

require 'rails_helper'

RSpec.describe "rsvps/new", type: :view do
  before(:each) do
    assign(:rsvp, Rsvp.new(
      first_name: "MyString",
      last_name: "MyString",
      phone_number: "MyString",
      email: "MyString",
      user: nil,
      event: nil
    ))
  end

  it "renders new rsvp form" do
    render

    assert_select "form[action=?][method=?]", rsvps_path, "post" do

      assert_select "input[name=?]", "rsvp[first_name]"

      assert_select "input[name=?]", "rsvp[last_name]"

      assert_select "input[name=?]", "rsvp[phone_number]"

      assert_select "input[name=?]", "rsvp[email]"

      assert_select "input[name=?]", "rsvp[user_id]"

      assert_select "input[name=?]", "rsvp[event_id]"
    end
  end
end

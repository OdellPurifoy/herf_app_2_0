require 'rails_helper'

RSpec.describe "rsvps/edit", type: :view do
  before(:each) do
    @rsvp = assign(:rsvp, Rsvp.create!(
      first_name: "MyString",
      last_name: "MyString",
      phone_number: "MyString",
      email: "MyString",
      user: nil,
      event: nil
    ))
  end

  it "renders the edit rsvp form" do
    render

    assert_select "form[action=?][method=?]", rsvp_path(@rsvp), "post" do

      assert_select "input[name=?]", "rsvp[first_name]"

      assert_select "input[name=?]", "rsvp[last_name]"

      assert_select "input[name=?]", "rsvp[phone_number]"

      assert_select "input[name=?]", "rsvp[email]"

      assert_select "input[name=?]", "rsvp[user_id]"

      assert_select "input[name=?]", "rsvp[event_id]"
    end
  end
end

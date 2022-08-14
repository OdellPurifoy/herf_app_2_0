require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      name: "MyString",
      event_type: "MyString",
      start_time_display: "MyString",
      end_time_display: "MyString",
      maximum_capacity: 1,
      rsvp_needed: false,
      lounge: nil
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[event_type]"

      assert_select "input[name=?]", "event[start_time_display]"

      assert_select "input[name=?]", "event[end_time_display]"

      assert_select "input[name=?]", "event[maximum_capacity]"

      assert_select "input[name=?]", "event[rsvp_needed]"

      assert_select "input[name=?]", "event[lounge_id]"
    end
  end
end

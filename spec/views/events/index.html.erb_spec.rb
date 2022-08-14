require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        name: "Name",
        event_type: "Event Type",
        start_time_display: "Start Time Display",
        end_time_display: "End Time Display",
        maximum_capacity: 2,
        rsvp_needed: false,
        lounge: nil
      ),
      Event.create!(
        name: "Name",
        event_type: "Event Type",
        start_time_display: "Start Time Display",
        end_time_display: "End Time Display",
        maximum_capacity: 2,
        rsvp_needed: false,
        lounge: nil
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Event Type".to_s, count: 2
    assert_select "tr>td", text: "Start Time Display".to_s, count: 2
    assert_select "tr>td", text: "End Time Display".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end

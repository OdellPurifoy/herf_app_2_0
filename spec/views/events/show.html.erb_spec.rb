require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      name: "Name",
      event_type: "Event Type",
      start_time_display: "Start Time Display",
      end_time_display: "End Time Display",
      maximum_capacity: 2,
      rsvp_needed: false,
      lounge: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Event Type/)
    expect(rendered).to match(/Start Time Display/)
    expect(rendered).to match(/End Time Display/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end

require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      body: "MyText",
      read: false,
      user: nil
    ))
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "textarea[name=?]", "notification[body]"

      assert_select "input[name=?]", "notification[read]"

      assert_select "input[name=?]", "notification[user_id]"
    end
  end
end

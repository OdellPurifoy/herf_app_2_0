require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    assign(:notification, Notification.new(
      body: "MyText",
      read: false,
      user: nil
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do

      assert_select "textarea[name=?]", "notification[body]"

      assert_select "input[name=?]", "notification[read]"

      assert_select "input[name=?]", "notification[user_id]"
    end
  end
end

require 'rails_helper'

RSpec.describe "special_offers/new", type: :view do
  before(:each) do
    assign(:special_offer, SpecialOffer.new(
      type: "",
      description: "MyText",
      lounge: nil
    ))
  end

  it "renders new special_offer form" do
    render

    assert_select "form[action=?][method=?]", special_offers_path, "post" do

      assert_select "input[name=?]", "special_offer[type]"

      assert_select "textarea[name=?]", "special_offer[description]"

      assert_select "input[name=?]", "special_offer[lounge_id]"
    end
  end
end

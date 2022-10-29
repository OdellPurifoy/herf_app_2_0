require 'rails_helper'

RSpec.describe "special_offers/edit", type: :view do
  before(:each) do
    @special_offer = assign(:special_offer, SpecialOffer.create!(
      type: "",
      description: "MyText",
      lounge: nil
    ))
  end

  it "renders the edit special_offer form" do
    render

    assert_select "form[action=?][method=?]", special_offer_path(@special_offer), "post" do

      assert_select "input[name=?]", "special_offer[type]"

      assert_select "textarea[name=?]", "special_offer[description]"

      assert_select "input[name=?]", "special_offer[lounge_id]"
    end
  end
end

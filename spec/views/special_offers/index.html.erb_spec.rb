require 'rails_helper'

RSpec.describe "special_offers/index", type: :view do
  before(:each) do
    assign(:special_offers, [
      SpecialOffer.create!(
        type: "Type",
        description: "MyText",
        lounge: nil
      ),
      SpecialOffer.create!(
        type: "Type",
        description: "MyText",
        lounge: nil
      )
    ])
  end

  it "renders a list of special_offers" do
    render
    assert_select "tr>td", text: "Type".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end

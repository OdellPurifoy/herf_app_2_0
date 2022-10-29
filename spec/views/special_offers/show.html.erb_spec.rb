require 'rails_helper'

RSpec.describe "special_offers/show", type: :view do
  before(:each) do
    @special_offer = assign(:special_offer, SpecialOffer.create!(
      type: "Type",
      description: "MyText",
      lounge: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end

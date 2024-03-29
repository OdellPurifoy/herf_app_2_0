require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/rsvps", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Rsvp. As you add validations to Rsvp, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Rsvp.create! valid_attributes
      get rsvps_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      rsvp = Rsvp.create! valid_attributes
      get rsvp_url(rsvp)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_rsvp_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      rsvp = Rsvp.create! valid_attributes
      get edit_rsvp_url(rsvp)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Rsvp" do
        expect {
          post rsvps_url, params: { rsvp: valid_attributes }
        }.to change(Rsvp, :count).by(1)
      end

      it "redirects to the created rsvp" do
        post rsvps_url, params: { rsvp: valid_attributes }
        expect(response).to redirect_to(rsvp_url(Rsvp.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Rsvp" do
        expect {
          post rsvps_url, params: { rsvp: invalid_attributes }
        }.to change(Rsvp, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post rsvps_url, params: { rsvp: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested rsvp" do
        rsvp = Rsvp.create! valid_attributes
        patch rsvp_url(rsvp), params: { rsvp: new_attributes }
        rsvp.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the rsvp" do
        rsvp = Rsvp.create! valid_attributes
        patch rsvp_url(rsvp), params: { rsvp: new_attributes }
        rsvp.reload
        expect(response).to redirect_to(rsvp_url(rsvp))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        rsvp = Rsvp.create! valid_attributes
        patch rsvp_url(rsvp), params: { rsvp: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested rsvp" do
      rsvp = Rsvp.create! valid_attributes
      expect {
        delete rsvp_url(rsvp)
      }.to change(Rsvp, :count).by(-1)
    end

    it "redirects to the rsvps list" do
      rsvp = Rsvp.create! valid_attributes
      delete rsvp_url(rsvp)
      expect(response).to redirect_to(rsvps_url)
    end
  end
end

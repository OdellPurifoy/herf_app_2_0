require "rails_helper"

RSpec.describe LoungeMembershipsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/lounge_memberships").to route_to("lounge_memberships#index")
    end

    it "routes to #new" do
      expect(get: "/lounge_memberships/new").to route_to("lounge_memberships#new")
    end

    it "routes to #show" do
      expect(get: "/lounge_memberships/1").to route_to("lounge_memberships#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/lounge_memberships/1/edit").to route_to("lounge_memberships#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/lounge_memberships").to route_to("lounge_memberships#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/lounge_memberships/1").to route_to("lounge_memberships#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/lounge_memberships/1").to route_to("lounge_memberships#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/lounge_memberships/1").to route_to("lounge_memberships#destroy", id: "1")
    end
  end
end

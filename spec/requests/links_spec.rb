require 'rails_helper'

RSpec.describe "Links", type: :request do
  let(:slug) { "fb" }
  let(:long_link) { "https://facebook.com" }

  describe "GET /show" do
    it "renders login template" do
      link = Link.create(url: "https://facebook.com", slug: slug)
      
      get "/s/#{slug}"
      expect(response).to redirect_to(long_link)
    end
  end
end

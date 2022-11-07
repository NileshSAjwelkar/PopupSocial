require 'rails_helper'

RSpec.describe "Landings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to render_template('landings/index')
    end
  end
end

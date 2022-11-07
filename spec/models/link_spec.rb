require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:url) { "http://someverylongurl.com/2/reallyverylong" }
  let(:slug) { "smallurl" }

  let(:short_url) { "http://localhost:3000/s/" }

  describe 'shorten' do
    it 'shortens the url' do
      expect(Link.shorten(url, slug)).to(eq("#{short_url}#{slug}"))
    end
  end
end

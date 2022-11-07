require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:content) { "This is post content with this url -> http://someverylongurl.com/2/reallyverylong" }
  let(:post) { create(:post, content: content) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_one_attached(:upload) }
  end

  describe 'shorten_links_in_content' do
    it 'shortens any url in content' do
      expect(post.content).not_to(eq(content))
      expect(post.content).to include("http://localhost:3000/s")
      expect(post.content).not_to include(content)
    end
  end
end

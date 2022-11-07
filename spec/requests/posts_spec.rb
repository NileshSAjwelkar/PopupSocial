require 'rails_helper'
require 'open-uri'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "renders posts listing template" do
      get "/posts"
      expect(response).to render_template('posts/index')
    end
  end

  describe "GET /posts/new" do
    it "renders new posts template" do
      get "/posts/new"
      expect(response).to render_template('posts/new')
    end
  end

  describe "GET /posts/:post_id" do
    it "renders new posts template" do
      post = create(:post)

      get "/posts/#{post.id}"
      expect(response).to render_template('posts/show')
    end
  end

  describe "GET /posts/:post_id/edit" do
    it "renders new posts template" do
      post = create(:post)
      
      get "/posts/#{post.id}/edit"
      expect(response).to render_template('posts/edit')
    end
  end

  describe "POST /posts" do
    it "renders creates posts" do
      user = create(:user)
      file = fixture_file_upload(Rails.root.join('public', 'opengraph.png'), 'image/jpg')
      content = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
      
      post "/posts", {params: {post: {title: "New Post", content: content, user_id: user.id, upload: file}}}

      expect(response).to redirect_to('/posts/1')
    end
  end

end
class Post < ApplicationRecord
  require "uri"
  act_as_mentioner
  acts_as_taggable_on :tags
  belongs_to :user
  
  has_many :comments, as: :commentable
  has_one_attached :upload
  
  before_validation :shorten_links_in_content, on: [ :create, :update ]

  def shorten_links_in_content
    return "" if self.content.blank?

    content = self.content

    all_links = URI.extract(content)

    all_links.each do |link|
      shortened_link = Link.shorten(link)
      content [link] = shortened_link
    end      
    self.content = content
  end
end

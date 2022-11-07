class Link < ApplicationRecord
  validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :slug

  before_validation :generate_slug

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end

  def generate_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
    true
  end

  def self.shorten(url, slug = '')
    link = Link.where(url: url, slug: slug).first
    return link.short if link  
    
    link = Link.new(url: url, slug: slug)
    return link.short if link.save
    
    Link.shorten(url, slug + SecureRandom.uuid[0..2])
  end
end

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, :summary, :body, presence: true
  has_rich_text :body

  has_many :taggings
  has_many :tag, through: :taggings

  def all_tags
    self.tag.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tag = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end

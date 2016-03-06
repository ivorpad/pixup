class Asset < ActiveRecord::Base

  # External Gems
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]
  mount_uploader :asset_file, AssetItemUploader
  before_save :update_asset_attributes

  # Validations
  validates_presence_of :title, :category

  # Associations
  belongs_to :project
  belongs_to :user
  belongs_to :category


  has_many :likes
  has_many :comments, as: :commentable, dependent: :destroy


  scope :images, -> { where(content_type: 'image') }
  scope :videos, -> { where(content_type: 'video') }

  # Public Methods

  def slug_candidates
   [
     :title,
     [:title, :title_sequence]
  ]
  end

  def title_sequence
   slug = normalize_friendly_id(title)
   sequence = Asset.where("slug like '#{slug}-%'").count + 2
  end

  def should_generate_new_friendly_id?
   title_changed?
  end

  private

  def update_asset_attributes
    if asset_file.present? && asset_file_changed?
      self.content_type = asset_file.file.content_type.split("/").first
    end
  end
end

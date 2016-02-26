class Asset < ActiveRecord::Base

  # External Gems
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]
  mount_uploader :asset_file, AssetItemUploader


  # Validations
  validates_presence_of :title, :category

  # Associations
  belongs_to :project
  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :asset_types

  # Public Methods

  def self.assets_fetcher_for(project, category)
    Asset.where(project_id: project.id, category_id: category.id)
  end

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

  def asset_image?
    image = %r{^image\/(jpg|png|gif)}
    self.asset_file.file.content_type.match(image)
  end

  def asset_application?
    application = %r{^application\/(pdf)}
    self.asset_file.file.content_type.match(application)
  end

  def asset_video?
    video = %r{^video\/(quicktime|mpeg)}
    self.asset_file.file.content_type.match(video)
  end

  def asset_audio?
    audio = %r{^audio\/(mpeg3|x-mpeg-3|mpeg|x-mpeg)}
    self.asset_file.file.content_type.match(audio)
  end

end

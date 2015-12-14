class PublishedSoftware < ActiveRecord::Base

  attr_accessor :delete_icon
  has_attached_file :icon, dependent: :destroy,
    styles: {
      small: "64x64^",
      medium: "128x128^",
      large: "256x256^" }
  has_many :videos, dependent: :destroy
  has_many :screenshots, dependent: :destroy

  default_scope { order('featured_software DESC, LOWER(title) ASC') }

  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  before_validation { icon.clear if delete_icon == '1' }

  accepts_nested_attributes_for :videos, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :screenshots, :reject_if => :all_blank, :allow_destroy => true

  acts_as_commentable
  acts_as_taggable

  validates :title, :presence => true
  validates :repository_url, :presence => true

  def self.list_all_tags_by_name
    all_tags.map(&:name).sort_by { |name| name.downcase }
  end

  def humanized_blueprint_html
    @humanized_blueprint_html ||= BlueprintHumanizer::Blueprint.new(blueprint).html
  end

  def list_tags_by_name
    tags.map(&:name).sort_by { |name| name.downcase }
  end

  def to_label
    title
  end

  def repository_handler
    RepositoryHandler.new(repository_url: repository_url)
  end

  def load_repository_data
    blueprint = repository_handler.load_blueprint_from_repository
    if blueprint
      self.blueprint = blueprint.to_json.to_s
      return true
    end
  rescue
    return false
  end

  def blueprint_software
    @blueprint_software ||= YAML.load(blueprint)['software']
  end

  def icon_url_from_blueprint
    blueprint_software['icon_url']
  end

  def default_engine_name
    blueprint_software['name']
  end

  def title_from_blueprint
    blueprint_software['full_title']
  end

  def description
    blueprint_software['description']
  end

  def license_title
    blueprint_software['license_label']
  end

  def license_url
    blueprint_software['license_sourceurl']
  end

  def home_page_url
    blueprint_software['home_page_url']
  end

  def support_page_url
    blueprint_software['support_page_url']
  end

  def about
    blueprint_software['about']
  end

  def framework
    [ blueprint_software['framework'], blueprint_software['language'] ].join("/")
  end

  def memory
    [ blueprint_software['required_memory'], blueprint_software['recommended_memory'] ].join(" - ")
  end

  def version
    [ blueprint_software['major'] || "0",
      blueprint_software['minor'] || "0",
      blueprint_software['patch'] || "0" ].join(".") + " " +
      (blueprint_software['release_level'] || "Releasecandidate")
  end

  def save
    update_icon_from_url_in_respository
    super
  end

  def update_icon_from_url_in_respository
    if icon_url_from_blueprint.present?
      self.icon = icon_from_url icon_url_from_blueprint
    end
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

  def icon_url_from_gallery
    if icon.present?
      'http://__HOST_WITH_PORT__' + self.icon.url
    else
      ''
    end
  end

  def library_software_record
    {
      label: title,
      detail: detail,
      repository_url: repository_url,
      website: website_from_blueprint,
      title: full_title_from_blueprint,
      fees_comment: fees_comment,
      icon_url: icon_url_from_gallery
    }
  end

private

  def icon_from_url url
    begin
      begin
        URI.parse(url)
      rescue Exception=>e
        nil
      end
    rescue
      nil
    end
  end

end

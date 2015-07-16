class PublishedSoftware < ActiveRecord::Base

  attr_accessor :delete_icon
  has_attached_file :icon, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :screenshots, dependent: :destroy

  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  before_validation { icon.clear if delete_icon == '1' }

  accepts_nested_attributes_for :videos, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :screenshots, :reject_if => :all_blank, :allow_destroy => true

  acts_as_commentable

  validates :title, :presence => true
  validates :repository_url, :presence => true

  def to_label
    title
  end

  def repository_handler

p :repository_handler
p repository_url

    RepositoryHandler.new(repository_url: repository_url)
  end

  def load_repository_data
p :load_repository_data
    blueprint = repository_handler.load_blueprint_from_repository
p :blueprint
p blueprint

    if blueprint
      self.blueprint = blueprint.to_json.to_s
      # self.website_from_blueprint = blueprint['software']['home_page']
      # self.default_engine_name_from_blueprint = blueprint['software']['name']
      # self.full_title_from_blueprint = blueprint['software']['full_title']
      # self.short_title_from_blueprint = blueprint['software']['short_title']
      # self.description_from_blueprint = blueprint['software']['description']
      # self.icon_url_from_blueprint = blueprint['software']['icon_url']
      # self.license_title_from_blueprint = blueprint['software']['license_label']
      # self.license_url_from_blueprint = blueprint['software']['license_sourceurl']
      return true
    end
  rescue
    return false
  end

  def blueprint_software

p :loading_blueprint
p blueprint

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

  def icon_url_from_gallery host_with_port
    if icon.present?
      'http://' + host_with_port + self.icon.url
    else
      ''
    end
  end

  def as_json(options = {host_with_port: ''})
    default_json = super
    default_json['icon_url_from_gallery'] = icon_url_from_gallery options[:host_with_port]
    default_json
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
class PublishedSoftware < ActiveRecord::Base

  attr_accessor :delete_icon
  has_attached_file :icon, :dependent => :destroy
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  before_validation { icon.clear if delete_icon == '1' }

  acts_as_commentable

  validates :title, :presence => true
  validates :repository_url, :presence => true

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
      self.website_from_blueprint = blueprint['software']['home_page']
      self.default_engine_name_from_blueprint = blueprint['software']['name']
      self.full_title_from_blueprint = blueprint['software']['full_title']
      self.short_title_from_blueprint = blueprint['software']['short_title']
      self.description_from_blueprint = blueprint['software']['description']
      self.icon_url_from_blueprint = blueprint['software']['icon_url']
      return true
    end
  rescue
    return false
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
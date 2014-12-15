class RepositoryHandler

  require 'git'
  # require "/opt/engines/lib/ruby/SysConfig.rb"

  attr_accessor :repository_url

  def initialize params
    @repository_url = params[:repository_url]
  end

  def load_blueprint_from_repository
p '$$$ Clone/load blueprint from repository'    
    buildname = File.basename(repository_url)
    segments = buildname.split('.')
    buildname = segments[0]
    clone_repo(repository_url,buildname)
    blueprint_filename =  "/tmp/" + buildname.to_s + "/blueprint.json"
    blueprint_file = File.open(blueprint_filename,"r")
    blueprint_json_str = blueprint_file.read
    blueprint_file.close 
    bluePrint = JSON.parse(blueprint_json_str)
    return bluePrint
  end

  def clone_repo(repo, buildname)
    backup_lastbuild repo
    Git.clone(repo, buildname, path: "/tmp/")
  end

  def backup_lastbuild repo
    buildname = File.basename(repo)
    segments = buildname.split('.')   
    buildname = segments[0]
    dir = "/tmp/" + buildname.to_s
    if Dir.exists?(dir)
      backup = dir + ".backup"
      if Dir.exists?(backup)
        FileUtils.rm_rf backup
      end
      FileUtils.mv(dir,backup)
    end     
  end

end
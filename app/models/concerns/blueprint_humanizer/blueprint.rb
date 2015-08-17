module BlueprintHumanizer
  class Blueprint

    def initialize(blueprint)
      @blueprint = YAML.load(blueprint)
    end

    def html
      "#{css}<div class='humanized_blueprint'>#{content}</div>".html_safe
    end

    def content
      steps #[intro, steps, footer].compact().join('<br>')
    end

  private

    def css
      "<style>
      .humanized_blueprint { line-height: 1.2; }
      .humanized_blueprint div.data_string { display: inline-block; line-height: 1.2; margin-left: 40px; }
      .humanized_blueprint label { padding-bottom: 5px; }
      .humanized_blueprint span.engines_parameter { color: #999; }
      .humanized_blueprint label { vertical-align: top; margin-top: 0px; }
      </style>"
    end

    def component_names
      [ 
        "custom_start_script",
        "service_configurations",
        "persistent_files",
        "installed_packages",
        "template_files",
        "file_write_permissions",
        "custom_php_inis",
        "modules",
        "framework_modules",
        "persistent_directories",
        "replacement_strings",
        "system_packages",
        "ports",
        "external_repositories",
        "workers",
        "rake_tasks",
        "apache_htaccess_files",
        "apache_modules",
        "variables",
        "component_sources",
        "apache_httpd_configurations",
        "pear_modules",
        "continuos_deployment",
        "database_seed file",
      ]

    end

    def software
      @blueprint["software"]
    end

    # def intro
    #  "<h3>Installation</h3>
    #   <p>Greetings from the end of the time...</p>"
    # end

    def steps
      Component.new("Blueprint (v0.1)", software).humanize
    end

    # def footer
    #   "That is all."
    # end

  end
end
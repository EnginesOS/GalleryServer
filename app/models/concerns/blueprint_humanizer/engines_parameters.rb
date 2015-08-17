module BlueprintHumanizer
  class EnginesParameters

    def initialize(raw_string)
      @raw_string = raw_string
    end

    def substituted
      @raw_string.
        gsub(
          /_Engines_*([^(]+?)\( *([^)]+?) *\)\)/,
          '<span class="engines_parameter">Engines '.html_safe + '\1' +
            " resolves '".html_safe + '\2)' + "'</span>".html_safe ).
        gsub(
          /_Engines_*([^(]+?)\( *([^)]+?) *\)/,
          '<span class="engines_parameter">Engines '.html_safe + '\1' +
            " resolves '".html_safe + '\2' + "'</span>".html_safe )
    end

  end
end
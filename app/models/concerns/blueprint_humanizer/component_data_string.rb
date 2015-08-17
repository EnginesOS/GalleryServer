module BlueprintHumanizer
  class ComponentDataString

    def initialize(string)
      @string = string.strip.gsub("\r\n", '<br>').html_safe
    end

    def humanize
      EnginesParameters.new(@string).substituted.html_safe
    end

  end
end
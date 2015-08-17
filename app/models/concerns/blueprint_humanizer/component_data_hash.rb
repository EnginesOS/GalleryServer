module BlueprintHumanizer
  class ComponentDataHash

    def initialize(hash)
      @hash = hash
    end

    def humanize
      @hash.map{ |component_name, component_data| Component.new(component_name, component_data).humanize }.join()
    end

  end
end
module QueryStringSearch
  class MatcherFactory
    def self.build(search_option, build_options)
      constructor = build_options.detect { |m| m.build_me?(search_option) }

      if constructor
        constructor.new(search_option.search_type, search_option.search_param)
      end
    end
  end
end

module QueryStringSearch
  class MatcherFactory
    def self.build(search_option, build_options)
      matcher_to_build = build_options.detect { |m| m.build_me?(search_option) }

      if matcher_to_build
        matcher_to_build.new(search_option.search_type, search_option.search_param)
      end
    end
  end
end

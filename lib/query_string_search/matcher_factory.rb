module QueryStringSearch
  class MatcherFactory
    def self.build(search_option, build_options)
      matcher_to_build = build_options.detect { |m| m.build_me?(search_option) }

      if matcher_to_build
        matcher               = matcher_to_build.new
        matcher.attribute     = search_option.attribute
        matcher.desired_value = search_option.desired_value
        matcher.operator      = search_option.operator
        matcher
      end
    end
  end
end

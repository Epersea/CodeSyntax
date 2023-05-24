class Character

    OPENING_SHOVEL = '<'
    CLOSING_SHOVEL = '>'
    OPENING_BRACKET = '['
    CLOSING_BRACKET = ']'

    PAIRS = {
        OPENING_SHOVEL => CLOSING_SHOVEL,
        OPENING_BRACKET => CLOSING_BRACKET
    }

    class << self

        def incompatible_characters?(string)
            bracket_cuts_shovels = "#{OPENING_SHOVEL}#{CLOSING_BRACKET}"
            shovel_cuts_brackets = "#{OPENING_BRACKET}#{CLOSING_SHOVEL}"

            string.include?(bracket_cuts_shovels) || string.include?(shovel_cuts_brackets)
        end

        def is_closing?(char)
            char == CLOSING_SHOVEL || char == CLOSING_BRACKET
        end

        def matching_closing(opening)
            PAIRS[opening]
        end

        def has_no_closings(code, closing)
            !code.include?(closing)
        end
    end

end
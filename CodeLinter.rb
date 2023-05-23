class CodeLinter

    OPENING_SHOVEL = '<'
    CLOSING_SHOVEL = '>'
    OPENING_BRACKET = '['
    CLOSING_BRACKET = ']'

    PAIRS = {
        OPENING_SHOVEL => CLOSING_SHOVEL,
        OPENING_BRACKET => CLOSING_BRACKET
    }

    def initialize(code)
        @code = code
    end

    def validate
        if symbols_cut_each_other?
            return false
        end

        parseable_code = @code.split('')

        matched_pairs?(parseable_code)
    end

    private

    def symbols_cut_each_other?
        bracket_cuts_shovels = "#{OPENING_SHOVEL}#{CLOSING_BRACKET}"
        shovel_cuts_brackets = "#{OPENING_BRACKET}#{CLOSING_SHOVEL}"

        @code.include?(bracket_cuts_shovels) || @code.include?(shovel_cuts_brackets)
    end

    def matched_pairs?(code)
        if is_closing?(code.first)
            return false
        else
            closing = matching_closing(code.first)

            if has_no_closings(code, closing)
                return false
            end

            code.each do |char|
                if char == closing
                    code = delete_valid_pair(code, closing)

                    if no_chars_left(code)
                        return true
                    elsif one_char_left(code)
                        return false
                    elsif two_or_more_chars_left(code)
                        return matched_pairs?(code)
                    end
                end
            end
        end
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

    def delete_valid_pair(code, closing)
        closing_index = code.find_index(closing)
        code.delete_at(closing_index)
        code.shift

        code
    end

    def no_chars_left(code)
        code.length == 0
    end

    def one_char_left(code)
        code.length == 1
    end

    def two_or_more_chars_left(code)
        code.length >= 2
    end
end



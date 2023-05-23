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
        return matched_pairs?(parseable_code)
    end

    private

    def symbols_cut_each_other?
        return @code.include?("#{OPENING_SHOVEL}#{CLOSING_BRACKET}") || @code.include?("#{OPENING_BRACKET}#{CLOSING_SHOVEL}")
    end

    def matched_pairs?(code)
        if is_closing?(code[0])
            return false
        else
            closing = matching_closing(code[0])

            if !code.include?(closing)
                return false
            end

            code.each do |char|
                if char == closing
                    code = delete_valid_pair(code, closing)

                    if code.length == 0
                        return true
                    elsif code.length == 1
                        return false
                    elsif code.length >= 2
                        return matched_pairs?(code)
                    end
                end
            end
        end
    end

    def is_closing?(char)
        return char == CLOSING_SHOVEL || char == CLOSING_BRACKET
    end

    def matching_closing(opening)
        PAIRS[opening]
    end

    def delete_valid_pair(code, closing)
        closing_index = code.find_index(closing)
        code.delete_at(closing_index)
        code.shift

        return code
    end
end



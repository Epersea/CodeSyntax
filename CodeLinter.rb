class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        parseable_code = @code.split('')
        return matched_pairs?(parseable_code)
    end

    private

    def matched_pairs?(code)
        if is_closing?(code[0])
            return false
        else
            closing = matching_closing(code[0])
            code.shift

            if !code.include?(closing)
                return false
            end

            code.each do |char|
                if char == closing
                    closing_index = code.find_index(closing)
                    code.delete_at(closing_index)

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
end


def is_closing?(char)
    return char == '>' || char == ']'
end

def matching_closing(opening)
    if opening == '<'
        return '>'
    elsif opening == '['
        return ']'
    end
end

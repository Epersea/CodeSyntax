class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        if valid_opening? == false
            return false
        else
            parseable_code = @code.split('')
            return matched_pairs?(parseable_code, '<', '>')
        end
    end

    private

    def valid_opening?
        @code[0] == '<' || @code[0] == '['
    end

    def matched_pairs?(code, opening, closing)
        if code[0] == closing
            return false
        else
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
                        return matched_pairs?(code, opening, closing)
                    end
                end
            end
        end
    end
end

test_code = CodeLinter.new('<><><<>>')

is_valid = test_code.validate
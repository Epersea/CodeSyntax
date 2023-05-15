class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        if valid_opening? == false
            return false
        else
            parseable_code = @code.split('')
            p "Parseable code: #{parseable_code}"
            return matched_pairs?(parseable_code, '<', '>')
        end
        #return valid_opening? && valid_closing? && balanced_symbols? && no_syntax_errors?
    end

    private

    def valid_opening?
        @code[0] == '<' || @code[0] == '['
    end

    def valid_closing?
        @code[-1] == '>' || @code[-1] == ']'
    end

    def balanced_symbols?
        same_openings_and_closings?('<', '>') && same_openings_and_closings?('[', ']')
    end

    def same_openings_and_closings?(opening, closing)
        num_of_openings = 0
        num_of_closings = 0
        parseable_code = @code.split('')

        parseable_code.each do |char|
            if char == opening
                num_of_openings += 1
            elsif char == closing
                num_of_closings += 1
            end
        end

        return num_of_openings == num_of_closings
    end

    def no_syntax_errors?
        syntax_errors = [/<\]\[>/, /<\[>/, /<\]>/, /\[><\]/]

        syntax_errors.each do |error|
            if @code.match?(error)
                return false
            end
        end

        true
    end

    def matched_pairs?(code, opening, closing)
        p "Code at the start: #{code}"
        if code[0] == closing
            return false
        else
            code.shift
            p "Code after shift: #{code}"
            if !code.include?(closing)
                return false
            end
            code.each do |char|
                if char == closing
                    closing_index = code.find_index(closing)
                    code.delete_at(closing_index)
                    p "Code after deleting closing: #{code}"
                    p "Code length: #{code.length}"
                    if code.length == 0
                        return true
                        break
                    elsif code.length == 1
                        return false
                        break
                    elsif code.length >= 2
                        matched_pairs?(code, opening, closing)
                    end
                end
            end
        end
    end
end

test_code = CodeLinter.new('<><><<>>')

is_valid = test_code.validate
class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        return valid_opening? && valid_closing? && balanced_symbols? && no_syntax_errors?
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
end
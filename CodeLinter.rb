class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        return valid_opening && valid_closing && balanced_symbols && no_syntax_errors
    end

    private

    def valid_opening
        @code[0] == '<' || @code[0] == '['
    end

    def valid_closing
        @code[-1] == '>' || @code[-1] == ']'
    end

    def balanced_symbols
        angle_openings = 0
        angle_closings = 0
        square_openings = 0
        square_closings = 0
        parseableCode = @code.split('')

        parseableCode.each do |char|
            if char == '<'
                angle_openings += 1
            elsif char == '>'
                angle_closings += 1
            elsif char == '['
                square_openings += 1
            elsif char == ']'
                square_closings += 1
            end
        end

        return angle_openings == angle_closings && square_openings == square_closings
    end

    def no_syntax_errors
        syntax_errors = [/<\]\[>/, /<\[>/, /<\]>/, /\[><\]/]

        syntax_errors.each do |error|
            if @code.match?(error)
                return false
            end
        end

        true
    end
end
class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        return validOpening && validClosing && sameNumberOfSymbols
    end

    private

    def validOpening
        @code[0] == '<'
    end

    def validClosing
        @code[-1] == '>'
    end

    def sameNumberOfSymbols
        openings = 0
        
        closings = 0
        parseableCode = @code.split('')

        parseableCode.each do |char|
            if char == '<'
                openings += 1
            end
            if char == '>'
                closings += 1
            end
        end
        p parseableCode
        p "Number of openings: #{openings}"
        p "Number of closings: #{closings}"
        
        return openings == closings
    end
end
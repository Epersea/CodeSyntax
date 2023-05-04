class CodeLinter

    def initialize(code)
        @code = code
    end

    def validate
        return validOpening
    end

    private

    def validOpening
        @code[0] == '<'
    end
end
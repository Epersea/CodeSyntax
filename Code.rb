class Code

    class << self

        def has_no_char?(code, char)
            !code.include?(char)
        end

        def no_chars_left?(code)
            code.length == 0
        end

        def one_char_left?(code)
            code.length == 1
        end

        def two_or_more_chars_left?(code)
            code.length >= 2
        end
    end
end
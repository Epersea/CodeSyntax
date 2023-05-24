class CodeManipulator

    class << self

        def convert_code(code)
            code.split('')
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
end
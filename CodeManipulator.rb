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

    end
end
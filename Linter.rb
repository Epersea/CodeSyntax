require_relative 'Character.rb'
require_relative 'CodeManipulator.rb'
require_relative 'Code.rb'

class Linter

    def initialize(code)
        @code = code
    end

    def validate
        if Character.incompatible_characters?(@code)
            return false
        end

        parseable_code = CodeManipulator.convert_code(@code)

        matched_pairs?(parseable_code)
    end

    private


    def matched_pairs?(code)
        if Character.is_closing?(code.first)
            return false
        else
            closing = Character.matching_closing(code.first)

            if Code.has_no_char?(code, closing)
                return false
            end

            code.each do |char|
                if char == closing
                    code = CodeManipulator.delete_valid_pair(code, closing)

                    if Code.no_chars_left?(code)
                        return true
                    elsif Code.one_char_left?(code)
                        return false
                    elsif Code.two_or_more_chars_left?(code)
                        return matched_pairs?(code)
                    end
                end
            end
        end
    end
end



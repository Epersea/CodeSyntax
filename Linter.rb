require_relative 'Character.rb'
require_relative 'CodeManipulator.rb'

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

            if Character.has_no_closings(code, closing)
                return false
            end

            code.each do |char|
                if char == closing
                    code = CodeManipulator.delete_valid_pair(code, closing)

                    if CodeManipulator.no_chars_left(code)
                        return true
                    elsif CodeManipulator.one_char_left(code)
                        return false
                    elsif CodeManipulator.two_or_more_chars_left(code)
                        return matched_pairs?(code)
                    end
                end
            end
        end
    end
end



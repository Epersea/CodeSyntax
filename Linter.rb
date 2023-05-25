require_relative 'Character.rb'
require_relative 'CodeManipulator.rb'
require_relative 'Code.rb'

class Linter

    def initialize(program)
        @program = program
    end

    def validate
        if Character.incompatible_characters?(@program)
            return false
        end

        parseable_code = CodeManipulator.convert_code(@program)

        matched_pairs?(parseable_code)
    end

    private

    def matched_pairs?(program)
        if Character.is_closing?(program.first)
            return false
        else
            closing = Character.matching_closing(program.first)

            if Code.has_no_char?(program, closing)
                return false
            end

            program.each do |char|
                if char == closing
                    program = CodeManipulator.delete_valid_pair(program, closing)

                    if Code.no_chars_left?(program)
                        return true
                    elsif Code.one_char_left?(program)
                        return false
                    elsif Code.two_or_more_chars_left?(program)
                        return matched_pairs?(program)
                    end
                end
            end
        end
    end
end



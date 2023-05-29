require_relative 'Character.rb'
require_relative 'CodeManipulator.rb'
require_relative 'CodeChecker.rb'

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

            if CodeChecker.has_no_char?(program, closing)
                return false
            end

            program.each do |char|
                if char == closing
                    mutated_program = CodeManipulator.delete_valid_pair(program, closing)

                    if CodeChecker.no_chars_left?(mutated_program)
                        return true
                    elsif CodeChecker.one_char_left?(mutated_program)
                        return false
                    elsif CodeChecker.two_or_more_chars_left?(mutated_program)
                        return matched_pairs?(mutated_program)
                    end
                end
            end
        end
    end
end



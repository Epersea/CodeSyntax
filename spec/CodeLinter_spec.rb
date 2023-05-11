require_relative '../CodeLinter.rb'

RSpec.describe CodeLinter do

  it 'validates a correct expression with angle brackets' do
    test_code = CodeLinter.new('<><><<>>')

    is_valid = test_code.validate

    expect(is_valid).to eq(true)
  end

  it 'does not validate code that starts with >' do
    test_code = CodeLinter.new('><<>')

    is_valid = test_code.validate

    expect(is_valid).to eq(false)
  end

  it 'does not validate code that ends with <' do
    test_code = CodeLinter.new('<>><')

    is_valid = test_code.validate

    expect(is_valid).to eq(false)
  end

  it 'does not validate code if number of "<" and ">" is not the same' do
    test_code = CodeLinter.new('<>><>')

    is_valid = test_code.validate

    expect(is_valid).to eq(false)
  end

  it 'validates a correct expression with angle and square brackets' do
    test_code = CodeLinter.new('[<><>[]]')

    is_valid = test_code.validate

    expect(is_valid).to eq(true)
  end

  it 'does not validate code where sets of brackets interrupt each other' do
    test_code = CodeLinter.new('[<][>]<>')

    is_valid = test_code.validate

    expect(is_valid).to eq(false)
  end

end
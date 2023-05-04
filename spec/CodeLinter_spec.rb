require_relative '../CodeLinter.rb'

RSpec.describe CodeLinter do

  it 'does not validate code that starts with >' do
    test_code = CodeLinter.new('><>')

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

end
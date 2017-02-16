require 'spec_helper.rb'
require 'tempfile'

describe CodeCaser do
  describe CodeCaser::Caser do
    # let(:file) do
    #   f = Tempfile.new('example_file')
    #   f.write %q(
    #   // this snake_case comment should be ignored
    #   this_text will_be_converted
    #     so_will_this // but not_this_comment
    #   )
    #   f
    # end

    let(:caser) do
      CodeCaser::Caser.new(save: false,
                           path: file.path,
                           converter: CodeCaser::SnakeConverter.new,
                           ignore_after: '//')
    end

    # expect(file.read).to eq()
  end
end

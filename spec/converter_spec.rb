require 'spec_helper.rb'

describe CodeCaser do

  describe "Converters" do

    describe CodeCaser::CamelConverter do
      let(:conv) { CodeCaser::CamelConverter.new }
      it { should respond_to(:description) }
      it "should safely convert camelCase identifiers to snake_case" do
        {
          "IgnoreTitleCase"      => "IgnoreTitleCase",
          "IGNORE_CONSTANT_CASE" => "IGNORE_CONSTANT_CASE",
          "camelCase += 1"       => "camel_case += 1",
          "HTTPIsAnAcronym"      => "HTTPIsAnAcronym",
          "getHTTPResponse"      => "get_http_response",
          "_camelCase_"          => "_camel_case_",
          "__camelCase__"        => "__camel_case__"
        }.each do |camel, snake|
          expect(conv.convert_line(camel)).to eq(snake)
        end
      end
      # context "when ignore_title_case option is set" do
      #
      # end
    end

    describe CodeCaser::SnakeConverter do
      let(:conv) { CodeCaser::SnakeConverter.new }
      it { should respond_to(:description) }
      it "should safely convert snake_case identifiers to camelCase" do
        {
          "IgnoreTitleCase"                 => "IgnoreTitleCase",
          "IGNORE_CONSTANT_CASE"            => "IGNORE_CONSTANT_CASE",
          "snake_case += 1"                 => "snakeCase += 1",
          "alreadyCamelCase"                => "alreadyCamelCase",
          "doubles__left_intact"            => "doubles__leftIntact",
          "_outside_underscores_preserved_" => "_outsideUnderscoresPreserved_"
        }.each do |snake, camel|
          expect(conv.convert_line(snake)).to eq(camel)
        end
      end

      # context "when ignore_title_case option is set" do
      #
      # end
    end

  end
end

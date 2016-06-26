require 'spec_helper.rb'

describe CodeCaser do

  describe "Converters" do

    describe CodeCaser::CamelConverter do
      let(:conv) { CodeCaser::CamelConverter.new }
      it "should safely convert camelCase identifiers to snake_case" do
        {
          "camelCase += 1"  => "camel_case += 1",
          "HTTPIsAnAcronym" => "http_is_an_acronym",
          "getHTTPResponse" => "get_http_response",
          "_camelCase_"     => "_camel_case_",
          "__camelCase__"   => "__camel_case__"
        }.each do |camel, snake|
          expect(conv.convert_line(camel)).to eq(snake)
        end
      end
    end

    describe CodeCaser::SnakeConverter do
      let(:conv) { CodeCaser::SnakeConverter.new }
      it "should safely convert snake_case identifiers to camelCase" do
        {
          "snake_case += 1"                 => "snakeCase += 1",
          "alreadyCamelCase"                => "alreadyCamelCase",
          "doubles__left_intact"            => "doubles__leftIntact",
          "_outside_underscores_preserved_" => "_outsideUnderscoresPreserved_"
        }.each do |snake, camel|
          expect(conv.convert_line(snake)).to eq(camel)
        end
      end
    end
  end
end

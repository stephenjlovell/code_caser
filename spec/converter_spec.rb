require 'spec_helper.rb'

describe CodeCaser do

  describe "Converters" do

    describe CodeCaser::CamelConverter do
      let(:conv) { CodeCaser::CamelConverter.new }

      it "should safely convert camelCase identifiers to snake_case" do
        expect(conv.convert_line("camelCase += 1")).to       eq("camel_case += 1")
        expect(conv.convert_line("HTTPIsAnAcronym")).to eq("http_is_an_acronym")
        expect(conv.convert_line("getHTTPResponse")).to eq("get_http_response")
        expect(conv.convert_line("_camelCase_")).to     eq("_camel_case_")
        expect(conv.convert_line("__camelCase__")).to   eq("__camel_case__")
      end
    end

    describe CodeCaser::SnakeConverter do
      let(:conv) { CodeCaser::SnakeConverter.new }

      it "should safely convert snake_case identifiers to camelCase" do
        expect(conv.convert_line("snake_case += 1")).to           eq("snakeCase += 1")
        expect(conv.convert_line("alreadyCamelCase")).to          eq("alreadyCamelCase")
        # expect(conv.convert_line("")).to    eq("")
        expect(conv.convert_line("doubles__become_single")).to    eq("doubles_BecomeSingle")
        expect(conv.convert_line("_outside_underscores_preserved_")).to(
          eq("_outsideUnderscoresPreserved_"))
      end

    end
  end
end

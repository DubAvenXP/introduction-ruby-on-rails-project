require "rails_helper"
# require "support/helpers/response_helper"

module GenericExpects
    def expect_valid_string(value)
        generic_expects(value)
        expect(value).to be_a(String)
    end

    def expect_valid_integer(value)
        generic_expects(value)
        expect(value).to be_a(Integer)
    end

    def expect_valid_float(value)
        generic_expects(value)
        expect(value).to be_a(Float)
    end

    def expect_valid_boolean(value)
        generic_expects(value)
        expect(value).to be_in([true, false])
    end

    def generic_expects(value)
        expect(value).to_not be_nil
        expect(value).to_not be_blank
    end
    
end
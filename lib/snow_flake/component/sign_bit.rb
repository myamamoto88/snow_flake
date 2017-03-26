class SnowFlake
  module Component
    class SignBit < Base
      POSITIVE_BIT = 0

      include Constable

      def setup(config)
        @value = POSITIVE_BIT
      end

      def bits
        1
      end
    end
  end
end

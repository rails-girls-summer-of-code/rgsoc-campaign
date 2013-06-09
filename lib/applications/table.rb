module Applications
  class Table
    class Row
      attr_reader :names, :application

      def initialize(names, application)
        @names = names
        @application = application
      end

      def ratings
        @ratings ||= names.map do |name|
          rating = application.ratings.detect { |rating| rating.user_name == name }
          rating || Hashr.new(value: '-')
        end
      end
    end

    attr_reader :names, :rows

    def initialize(names, applications)
      @names = names
      @rows = applications.map { |application| Row.new(names, application) }
    end
  end
end

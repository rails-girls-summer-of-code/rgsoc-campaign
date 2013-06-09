module Applications
  class Table
    class Row
      attr_reader :names, :application

      def initialize(names, application)
        @names = names
        @application = application
      end

      def values
        @values ||= ratings.map(&:value)
      end

      private

        def ratings
          @ratings ||= names.map do |name|
            rating = application.ratings.select { |rating| rating.user_name == name }
            rating || Rating.new
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

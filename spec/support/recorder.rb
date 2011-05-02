module Support
  class Recorder
    def initialize
      require "stringio"
      @output = StringIO.new
    end

    def print(*args)
      @output.print *args
    end

    def puts(*args)
      @output.puts *args
    end

    def flush
      # noop
    end

    def contents
      @output.rewind
      @output.read
    end
  end
end

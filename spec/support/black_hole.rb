module Support
  class BlackHole
    def print(*args)
      # noop
    end

    def puts(*args)
      # noop
    end

    def flush
      # noop
    end
  end
end

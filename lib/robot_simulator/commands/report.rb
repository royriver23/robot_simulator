module Commands
  class Report < CommandTemplate
    def perform?
      true
    end

    def print
      # Use global outputters
    end

    alias execute print
  end
end

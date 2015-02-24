class Path
  def initialize(path)
    @path       = path
    @expression = Regexp.new(expression_string)
  end

  # @param  [String]
  # @return [MatchData]
  #
  def match(string)
    expression.match(string)
  end

private

  attr_reader :path
  attr_reader :expression

  def expression_string
    '^' << path.gsub(/:(\w+)/) { |match| '(?<' + $1 + '>(\w|-)+)' } << '$'
  end
end

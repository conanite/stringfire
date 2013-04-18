require "stringfire/version"

module Stringfire

  class Interpreter
    def split_first_word str
      result = str.strip.split /\s/, 2
      result << "" while result.size < 2
      result
    end

    def initialize
      @commands = { }
      default { |command, *args| command }
    end

    def command name, &block
      @commands[name] = block
    end

    def command_names
      @commands.keys
    end

    def default *args, &block
      if block_given?
        @default = block
      else
        @default.call *args
      end
    end

    def interpret command_text, *args
      name, details = split_first_word command_text
      if @commands.key? name
        @commands[name].call details, *args
      else
        default command_text, *args
      end
    end
  end

end

# Stringfire

Strip the first token off a string, pass remainder of string as arg to function identified by first token

Useful where you want user-supplied executable expressions embedded in your data (in a CMS for example), but for obvious reasons you're not going to let them write ruby code

## Installation

Add this line to your application's Gemfile:

    gem 'stringfire'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stringfire

## Usage

    @interpreter = Stringfire::Interpreter.new

    @interpreter.command("say-hello") { |arg| "hello, #{arg}" }

    @interpreter.interpret "say-hello dear user" # => "hello, dear user"

You can nest interpreters

    @interpreter.command("if-admin") { |arg| User.admin? ? @interpreter.interpret(arg) : "" }

    login_as(admin_user)
    @interpreter.interpret "if-admin say-hello dear user" # => "hello, dear user"

    logout
    @interpreter.interpret "if-admin say-hello dear user" # => ""

You can pass arbitrary additional args

    @interpreter.command("say-bye") { |arg, lovely, days| "bye-bye, #{arg}, it was #{lovely} to meet you, see you in #{days} days" }

    @interpreter.interpret("say-bye dear user", "wonderful", 2) # => "bye-bye, dear user, it was wonderful to meet you, see you in 2 days"

Additional args may be useful in a Rails context if you need to pass an ActionController or ActionView instance to your commands :

    @interpreter.command("tweets") { |arg, view| view.render_cell :tweets, :show, arg.split(/,/) }

    @interpreter.interpret("tweets conanite, 10, no-RT", view) # => same as calling view.render_cell(:tweets, :show, "conanite", "10", "no-RT")

You can specify a default handler for unknown commands

    @interpreter.default { |text, *args| raise "Unable to interpret '#{text}': available commands are #{@interpreter.command_names.join ', '}" }

    @interpreter.interpret("foobar toto james anthony krishna", 1, 2, 3) # => Error: Unable to interpret 'foobar toto james anthony krishna': available commands are say-hello, if-admin, say-bye


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

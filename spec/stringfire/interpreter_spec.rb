# -*- coding: utf-8 -*-

require File.expand_path('../../spec_helper', __FILE__)

describe Stringfire::Interpreter do

  class User
    attr_accessor :admin
  end

  let(:interpreter) { Stringfire::Interpreter.new }

  let(:user) { User.new }

  before {
    interpreter.command("say-hello") { |arg| "hello, #{arg}" }
    interpreter.command("if-admin") { |arg| user.admin ? interpreter.interpret(arg) : "" }
    interpreter.command("say-bye") { |arg, lovely, days| "bye-bye, #{arg}, it was #{lovely} to meet you, see you in #{days} days" }
    interpreter.command("tweets") { |arg, view| view.render_cell :tweets, :show, *arg.split(/\s*,\s*/) }
    interpreter.default { |text, *args| raise "Unable to interpret '#{text}': available commands are #{interpreter.command_names.join ', '}" }
  }

  it "should say hello" do
    interpreter.interpret("say-hello dear user").should == "hello, dear user"
  end

  it "should say hello to admin" do
    user.admin = true
    interpreter.interpret("if-admin say-hello dear user").should == "hello, dear user"
  end

  it "should say nothing to non-admin" do
    user.admin = false
    interpreter.interpret("if-admin say-hello dear user").should == ""
  end

  it "should say goodbye with axtra args" do
    interpreter.interpret("say-bye dear user", "wonderful", 2).should == "bye-bye, dear user, it was wonderful to meet you, see you in 2 days"
  end

  it "should be useful in a Rails context" do
    view = mock("view")
    view.should_receive(:render_cell).with(:tweets, :show, "conanite", "10", "no-RT").and_return "conanite's fascinating tweets"

    interpreter.interpret("tweets conanite, 10, no-RT", view).should == "conanite's fascinating tweets"
  end

  it "should be unable to interpret foobar" do
    Proc.new {
      interpreter.interpret("foobar toto james anthony krishna", 1, 2, 3)
    }.should raise_error RuntimeError, "Unable to interpret 'foobar toto james anthony krishna': available commands are say-hello, if-admin, say-bye, tweets"

  end
end



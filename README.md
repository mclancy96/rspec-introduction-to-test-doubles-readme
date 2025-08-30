# RSpec: Introduction to Test Doubles

Welcome to Lesson 16! In this lesson, we're going to demystify one of the most powerful tools in your RSpec toolkit: **test doubles**. If you've ever wondered how to test code that depends on things like APIs, databases, or other classes—without actually using those real dependencies—test doubles are your answer. We'll explain what they are, why they're so useful, and how to use them in RSpec with the `double` method. We'll also walk through lots of scenarios, examples, and edge cases, so you'll feel confident using doubles in your own specs.

---

## What is a Test Double?

A **test double** is a fake object you use in your tests to stand in for a real object. Think of it as a stunt double in a movie: it looks and acts like the real thing, but it's just there for the tricky scenes! In RSpec, test doubles let you:

- Isolate the code you're testing from its dependencies
- Control the behavior of collaborators (other objects your code interacts with)
- Avoid slow, unpredictable, or unavailable resources (like APIs, databases, or file systems)

### Analogy

Imagine you're testing a car, but you don't want to use a real engine (too expensive, too slow, or maybe you just don't have one handy). You use a fake engine—a test double—that pretends to be an engine for the purposes of your test.

---

## Why Use Test Doubles?

Test doubles are essential for writing fast, reliable, and focused tests. Here are some reasons to use them:

- **Isolation:** Test only the code you care about, not its dependencies.
- **Speed:** Avoid slow operations (like hitting a real database or API).
- **Control:** Make dependencies return exactly what you want, when you want.
- **Predictability:** Eliminate randomness and flakiness from your tests.
- **Safety:** Avoid making real network calls, sending emails, or modifying real data.

---

## The `double` Method: Creating a Test Double

RSpec provides the `double` method to create a test double. You can give it a name (for readability) and stub methods on it.

### Stubbing vs Expectation

When working with doubles, you’ll often see two patterns:

- **Stubbing** (using `allow(...).to receive(...)`): This sets up a method on the double to return a value if it’s called, but doesn’t require it to be called.
- **Expectation** (using `expect(...).to receive(...)`): This sets up a method that must be called during the test, or the test will fail.

In this lesson, we focus on stubbing for control and isolation. You’ll see expectations with doubles more in later lessons.

### Basic Example

```ruby
# /spec/test_doubles_spec.rb
RSpec.describe "Test Doubles" do
  it "uses a double" do
    greeter = double("Greeter", greet: "Hello!")
    expect(greeter.greet).to eq("Hello!")
  end
end
```

**What happens?**

We create a double named "Greeter" and tell it to respond to `greet` with "Hello!". When we call `greeter.greet`, it returns "Hello!"—no real Greeter class needed!

**Example Output:**

```zsh
Test Doubles
  uses a double

Finished in 0.00123 seconds (files took 0.12345 seconds to load)
1 example, 0 failures
```

---

## More Scenarios & Examples

### Scenario 1: Faking a Printer

```ruby
# /spec/test_doubles_spec.rb
RSpec.describe "Printer Double" do
  it "pretends to print" do
    printer = double("Printer")
    allow(printer).to receive(:print).and_return("Printing...")
    expect(printer.print).to eq("Printing...")
  end
end
```

### Scenario 2: Faking a Dependency in a Class

Suppose you have a `Report` class that uses a `Printer`:

```ruby
# /app/report.rb
class Report
  def initialize(printer)
    @printer = printer
  end

  def print_report
    @printer.print
  end
end
```

You can test `Report` without a real printer:

```ruby
# /spec/report_spec.rb
RSpec.describe Report do
  it "uses a printer double" do
    printer = double("Printer", print: "Printed!")
    report = Report.new(printer)
    expect(report.print_report).to eq("Printed!")
  end
end
```

### Scenario 3: Stubbing Multiple Methods

```ruby
# /spec/test_doubles_spec.rb
user = double("User", name: "Alice", admin?: true)
expect(user.name).to eq("Alice")
expect(user.admin?).to be true
```

### Scenario 4: What Happens If You Call a Method That Wasn't Stubbed?

```ruby
# /spec/test_doubles_spec.rb
printer = double("Printer")
expect { printer.print }.to raise_error(RSpec::Mocks::MockExpectationError)
```

By default, doubles only respond to methods you've told them about. This helps catch typos and mistakes!

---

## Edge Cases & Gotchas

- If you call a method on a double that you haven't stubbed, you'll get an error (unless you use `as_null_object`).
- Doubles don't check if the real class actually has those methods—unless you use *verifying doubles* (which you'll learn about in the next lesson: verifying doubles check that your stubs match real methods on real classes or objects).

---

## Visual: How Test Doubles Isolate Dependencies

Here's a simple diagram to show how doubles help isolate your code under test:

```zsh
Your code (e.g., Report)
  |
  |---> [Dependency] (e.g., Printer)
  |         |
  |         |---> [Real method: slow, side effects, etc.]
  |
  |---> [Test Double] (e.g., Printer double)
         |
         |---> [Controlled return value, no side effects]
```

---

## What's Next?

In the next lesson, you'll learn about verifying doubles—doubles that check your stubs against real classes or objects for extra safety. Then, in Lab 5, you'll get to practice using test doubles in your own specs!

- You can change what a double returns at any time with `allow(...).to receive`.

---

## When Should You Use Test Doubles?

- When you want to test code in isolation
- When a dependency is slow, unreliable, or unavailable
- When you want to control what a collaborator returns
- When you want to avoid side effects (like sending emails or making API calls)

---

## Practice Prompts

Try these exercises to reinforce your learning:

1. Create a double for a `Printer` and stub a `print` method. What happens if you call a method you didn't stub?
2. Use a double to fake a dependency in a class (like a `Mailer` or `Logger`).
3. Create a double with multiple stubbed methods and test their return values.
4. Try to use a double for a method that doesn't exist—what error do you get?
5. Why might you want to use a double instead of a real object in a spec?

---

## Resources

- [RSpec: Test Doubles](https://relishapp.com/rspec/rspec-mocks/v/3-10/docs/basics/test-doubles)
- [RSpec: allow/receive](https://relishapp.com/rspec/rspec-mocks/v/3-10/docs/basics/allowing-messages)
- [Better Specs: Doubles](https://www.betterspecs.org/#doubles)
- [Ruby Guides: RSpec Doubles](https://www.rubyguides.com/2018/07/rspec/)

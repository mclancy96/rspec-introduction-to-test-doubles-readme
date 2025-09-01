
# RSpec: Introduction to Test Doubles (MovieTicket & Theater Edition)

Welcome to Lesson 16! In this lesson, you'll master **test doubles** using a MovieTicket/Theater domain. Test doubles let you fake out dependencies, control collaborator behavior, and write fast, reliable, isolated tests. All examples use MovieTicket and Theater for clarity and realism.

---

## What is a Test Double?

A **test double** is a fake object you use in your tests to stand in for a real object. Think of it as a stunt double in a movie: it looks and acts like the real thing, but it's just there for the tricky scenes! In RSpec, test doubles let you:

- Isolate the code you're testing from its dependencies
- Control the behavior of collaborators (other objects your code interacts with)
- Avoid slow, unpredictable, or unavailable resources (like APIs, databases, or file systems)

### Analogy

Imagine you're testing a theater, but you don't want to use a real ticket printer (too expensive, too slow, or maybe you just don't have one handy). You use a fake ticket printer—a test double—that pretends to be a printer for the purposes of your test.

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
RSpec.describe "MovieTicket and Theater Test Doubles" do
  it "uses a double for MovieTicket" do
    ticket = double("MovieTicket", title: "Inception", price: 12.5)
    expect(ticket.title).to eq("Inception")
    expect(ticket.price).to eq(12.5)
  end
end
```

**What happens?**

We create a double named "MovieTicket" and tell it to respond to `title` and `price`. When we call `ticket.title`, it returns "Inception"—no real MovieTicket class needed!

**Example Output:**

```zsh
Test Doubles
  uses a double

Finished in 0.00123 seconds (files took 0.12345 seconds to load)
1 example, 0 failures
```

---

## More Scenarios & Examples

### Scenario 1: Faking a Ticket Printer

```ruby
# /spec/test_doubles_spec.rb
ticket = double("MovieTicket")
allow(ticket).to receive(:print).and_return("Ticket printed!")
expect(ticket.print).to eq("Ticket printed!")
```

### Scenario 2: Faking a Dependency in a Class

Suppose you have a `Theater` class that uses a `MovieTicket`:

```ruby
# /lib/theater.rb
class Theater
  def sell_ticket(title, price)
    "Sold ticket for #{title} at $#{price}"
  end
end
```

You can test `Theater` without a real MovieTicket:

```ruby
# /spec/test_doubles_spec.rb
ticket = double("MovieTicket", print: "Ticket for Inception: $12.5")
theater = Theater.new
expect(ticket.print).to eq("Ticket for Inception: $12.5")
```

### Scenario 3: Stubbing Multiple Methods

```ruby
theater = double("Theater", open?: true, show_movie: "Now showing: Inception")
expect(theater.open?).to eq(true)
expect(theater.show_movie("Inception")).to eq("Now showing: Inception")
```

### Scenario 4: What Happens If You Call a Method That Wasn't Stubbed?

```ruby
ticket = double("MovieTicket")
expect { ticket.price }.to raise_error(RSpec::Mocks::MockExpectationError)
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

## Getting Hands-On

Ready to practice? Here’s how to get started:

1. **Fork and clone this repo to your own GitHub account.**
2. **Install dependencies:**

    ```zsh
    bundle install
    ```

3. **Run the specs:**

    ```zsh
    bin/rspec
    ```

4. **Explore the code:**

   - All lesson code uses the MovieTicket and Theater domain (see `lib/` and `spec/test_doubles_spec.rb`).
   - Review the examples for creating and using test doubles.

5. **Implement the pending specs:**

   - Open `spec/test_doubles_spec.rb` and look for specs marked as `pending`.
   - Implement the real methods in `lib/movie_ticket.rb` or `lib/theater.rb` as needed so the pending specs pass.

6. **Re-run the specs** to verify your changes!

**Challenge:** Try writing your own spec using a double for a new method on MovieTicket or Theater.

---

## Resources

- [RSpec: Test Doubles](https://relishapp.com/rspec/rspec-mocks/v/3-10/docs/basics/test-doubles)
- [RSpec: allow/receive](https://relishapp.com/rspec/rspec-mocks/v/3-10/docs/basics/allowing-messages)
- [Better Specs: Doubles](https://www.betterspecs.org/#doubles)
- [Ruby Guides: RSpec Doubles](https://www.rubyguides.com/2018/07/rspec/)

# MicroLogger [![[version]](https://badge.fury.io/rb/microevent.svg)](https://badge.fury.io/rb/microevent)  [![[CI]](https://github.com/janlelis/micrologger/workflows/Test/badge.svg)](https://github.com/janlelis/micrologger/actions?query=workflow%3ATest)

A minimal logger based on [MicroEvent](https://github.com/janlelis/microevent.rb).

## Setup

Add to your `Gemfile`

```ruby
gem 'micrologger'
```

## How to Use It

A new logger has to be configured what should be done on log events using handler procs. There are two default handlers for logging to STDOUT/STDERR included:

```ruby
$logger = MicroLogger.new
$logger.register :info, :stdout
$logger.register :fatal, :stderr

$logger.log "debug" # STDOUT: debug
$logger.log "error", :fatal # STDERR: error
```

For any andvanced or customized behaviour, you will need to register your own blocks/procs:


### Example: Log to File

```ruby
$logger = MicroLogger.new
$logger.register :warn, :stderr
$logger.register :warn do |message, meta|
  File.open("logfile.#{meta[:level]}.txt", "a"){ |f| f.puts "#{meta[:time]} | #{message}" }
end

$logger.log "hey", :warn # Will write to STDERR and logfile.warn.txt
```

Other ideas you could do: Send data to a remote endpoint, send emails, send to analytics...


## J-_-L

Copyright (c) 2015 [Jan Lelis](https://janlelis.com). See MIT-LICENSE for details.

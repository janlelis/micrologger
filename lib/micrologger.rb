require_relative 'micrologger/version'

require 'microevent'
require 'paint'

class MicroLogger
  include MicroEvent

  DEFAULT_HANDLERS = {
    stdout: lambda{ |message, extra|
      STDOUT.puts formatter(message, extra)
    },
    stderr: lambda{ |message, extra|
      STDERR.puts Paint[formatter(message, extra), :red]
    },
  }

  def log(message, level = :info, extra = {})
    trigger level, message, {level: level, time: Time.now}.merge(extra)
  end

  def register(level = :info, handler = nil, &block)
    bind level, &resolve_handler(handler || block)
  end

  def unregister(level = :info, handler = nil, &block)
    if handler || block
      unbind level, &resolve_handler(handler || block)
    else
      unbind level
    end
  end


  private

  def resolve_handler(handler)
    if handler.is_a?(Proc)
      handler
    elsif default_handler = DEFAULT_HANDLERS[handler]
      default_handler
    else
      raise ArgumentError, "no suitable handler found for #{handler.inspect}"
    end
  end

  def formatter(message, extra)
    "#{extra[:time].strftime('%Y-%m-%d %H:%M')} | #{extra[:level]} | #{message}"
  end
end


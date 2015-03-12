require_relative '../lib/micrologger'
require 'minitest/autorun'

describe MicroLogger do
  let :logger do
    MicroLogger.new
  end

  describe '#log' do
    it 'calls registered handler for called log level' do
      result = []

      logger.register :debug, proc{ result << 42 }
      logger.log "msg", :debug

      assert_equal [42], result
    end

    it 'it passes the message to the handler' do
      result = []

      logger.register :debug, proc{ |message| result << message }
      logger.log "msg", :debug

      assert_equal ["msg"], result
    end

    it 'passes an "extra" meta info hash to the handler' do
      result = nil

      logger.register :debug, proc{ |message, extra| result = extra }
      logger.log "msg", :debug

      assert_equal Hash, result.class
    end

    it 'contains the current time in extra hash' do
      result = nil

      logger.register :debug, proc{ |message, extra| result = extra }
      logger.log "msg", :debug

      assert_equal Time, result[:time].class
    end

    it 'contains the log level in extra hash' do
      result = nil

      logger.register :debug, proc{ |message, extra| result = extra }
      logger.log "msg", :debug

      assert_equal :debug, result[:level]
    end

    it 'works with multiple handlers' do
      result = []

      logger.register :debug, proc{ result << 42 }
      logger.register :debug, proc{ result << 23 }
      logger.log "msg", :debug

      assert_equal [42, 23], result
    end

    it 'will use the :info log level if none is given' do
      result = []

      logger.register :info, proc{ result << 42 }
      logger.log "msg"

      assert_equal [42], result
    end
  end

  describe '#register' do
    it 'will bind a new proc handler for a log level' do
      result = []
      fn = proc{ result << 42 }

      logger.register :debug, fn
      logger.log "msg", :debug

      assert_equal [42], result
    end

    it 'also takes a block as handler' do
      result = []

      logger.register(:debug){ result << 42 }
      logger.log "msg", :debug

      assert_equal [42], result
    end

    it 'will raise an ArgumentError if no handler given' do
      result = nil

      begin
        logger.register :debug
      rescue => result
      end

      assert_equal ArgumentError, result.class
    end

    it 'will use the :info log level if is none is given' do
      result = []

      logger.register{ result << 42 }
      logger.log "msg"

      assert_equal [42], result
    end
  end

  describe '#unregister' do
    it 'will unregister a handler for a log level' do
      result = []
      fn = proc{ result << 42 }

      logger.register :debug, fn
      logger.unregister :debug, fn
      logger.log "msg", :debug

      assert_equal [], result
    end

    it 'will unregister all handlers if none is given' do
      result = []
      fn = proc{ result << 42 }

      logger.register :debug, fn
      logger.unbind :debug
      logger.log "msg", :debug

      assert_equal [], result
    end
  end

  describe 'DEFAULT_HANDLERS' do
    it 'contains a :stdout handler' do
      # assert_output "msg", "" do
      #   logger.register :debug, :stdout
      #   logger.log "msg", :debug
      # end
    end

    it 'contains a :stderr handler' do
      # assert_output "", "msg" do
      #   logger.register :debug, :stderr
      #   logger.log "msg", :debug
      # end
    end
  end
end

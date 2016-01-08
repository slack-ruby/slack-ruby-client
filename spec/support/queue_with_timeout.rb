# http://spin.atomicobject.com/2014/07/07/ruby-queue-pop-timeout/
class QueueWithTimeout
  def initialize
    @mutex = Mutex.new
    @queue = []
    @recieved = ConditionVariable.new
  end

  def push(x)
    @mutex.synchronize do
      @queue << x
      @recieved.signal
    end
  end

  def <<(x)
    push(x)
  end

  def pop(non_block = false)
    pop_with_timeout(non_block ? 0 : nil)
  end

  def pop_with_timeout(timeout = nil)
    @mutex.synchronize do
      if @queue.empty?
        @recieved.wait(@mutex, timeout) if timeout != 0
        # if we're still empty after the timeout, raise exception
        fail ThreadError, 'queue empty' if @queue.empty?
      end
      @queue.shift
    end
  end
end

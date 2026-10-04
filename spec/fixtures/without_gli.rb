# frozen_string_literal: true

# Loaded with `ruby -r` to run bin/slack as if the gli gem were not installed.
module Kernel
  alias require_without_gli_stub require

  def require(name)
    raise LoadError, "cannot load such file -- #{name}" if name == 'gli'

    require_without_gli_stub(name)
  end
end

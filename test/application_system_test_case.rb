# frozen_string_literal: true

require 'test_helper'

# This is your application system test case.
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end

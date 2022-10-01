# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    get bulletins_path
    assert_response :success
  end

  test '#show' do
    bulletin = bulletins(:one)
    get bulletin_path(bulletin)
    assert_response :success
  end
end

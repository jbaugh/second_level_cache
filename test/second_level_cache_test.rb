require 'test_helper'

class SecondLevelCacheTest < ActiveSupport::TestCase
  def setup
    @user = User.create name: 'csdn', email: 'test@csdn.com'
    @post = Post.create slug: 'foobar', topic_id: 2
  end

  def test_should_get_cache_key
    assert_equal "slc/users/#{@user.id}/#{User::CACHE_VERSION}", @user.second_level_cache_key
  end

  def test_should_use_column_info_with_no_version
    assert_equal "slc/posts/#{@post.id}/#{Post.column_names.sum.sum}", @post.second_level_cache_key
  end

  def test_should_write_and_read_cache
    @user.write_second_level_cache
    refute_nil User.read_second_level_cache(@user.id)
    @user.expire_second_level_cache
    assert_nil User.read_second_level_cache(@user.id)
  end
end

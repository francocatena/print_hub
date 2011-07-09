require 'test_helper'

class StatsControllerTest < ActionController::TestCase
  test 'should get printers stats' do
    UserSession.create(users(:administrator))
    get :printers
    assert_response :success
    assert_not_nil assigns(:printers_count)
    assert_select '#error_body', false
    assert_template 'stats/printers'
  end

  test 'should get filtered printers stats' do
    UserSession.create(users(:administrator))
    get :printers, :interval => {
      :from => 1.day.ago.to_datetime.to_s(:db),
      :to => 1.day.from_now.to_datetime.to_s(:db)
    }
    assert_response :success
    assert_not_nil assigns(:printers_count)
    assert_equal 2, assigns(:printers_count).size
    assert_equal PrintJob.sum(:printed_pages), assigns(:printers_count).sum(&:second)
    assert_select '#error_body', false
    assert_template 'stats/printers'
  end

  test 'should get filtered printers stats with 0 printed pages' do
    UserSession.create(users(:administrator))
    get :printers, :interval => {
      :from => 2.years.ago.to_datetime.to_s(:db),
      :to => 1.year.ago.to_datetime.to_s(:db)
    }
    assert_response :success
    assert_not_nil assigns(:printers_count)
    assert_equal 0, assigns(:printers_count).size
    assert_equal 0, assigns(:printers_count).sum(&:second)
    assert_select '#error_body', false
    assert_template 'stats/printers'
  end
  
  test 'should get users stats' do
    UserSession.create(users(:administrator))
    get :users
    assert_response :success
    assert_not_nil assigns(:users_count)
    assert_select '#error_body', false
    assert_template 'stats/users'
  end

  test 'should get filtered users stats' do
    UserSession.create(users(:administrator))
    get :users, :interval => {
      :from => 1.day.ago.to_datetime.to_s(:db),
      :to => 1.day.from_now.to_datetime.to_s(:db)
    }
    assert_response :success
    assert_not_nil assigns(:users_count)
    assert_equal 2, assigns(:users_count).size
    assert_equal PrintJob.sum(:printed_pages), assigns(:users_count).sum(&:second)
    assert_select '#error_body', false
    assert_template 'stats/users'
  end

  test 'should get filtered users stats with 0 printed pages' do
    UserSession.create(users(:administrator))
    get :users, :interval => {
      :from => 2.years.ago.to_datetime.to_s(:db),
      :to => 1.year.ago.to_datetime.to_s(:db)
    }
    assert_response :success
    assert_not_nil assigns(:users_count)
    assert_equal 0, assigns(:users_count).size
    assert_equal 0, assigns(:users_count).sum(&:second)
    assert_select '#error_body', false
    assert_template 'stats/users'
  end
end
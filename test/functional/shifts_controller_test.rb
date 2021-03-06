require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase
  setup do
    @shift = shifts(:current_shift)
    
    UserSession.create(users(:administrator))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:shifts)
    assert_select '#unexpected_error', false
    assert_template 'shifts/index'
  end

  test 'should create shift' do
    assert_difference('Shift.count') do
      post :create, shift: {
        start: 10.minutes.ago,
        finish: nil,
        description: 'Some shift',
        user_id: users(:administrator).id,
        paid: false
      }
    end

    assert_redirected_to shifts_url
  end

  test 'should show shift' do
    get :show, id: @shift
    assert_response :success
    assert_select '#unexpected_error', false
    assert_template 'shifts/show'
  end

  test 'should get edit' do
    get :edit, id: @shift
    assert_response :success
    assert_select '#unexpected_error', false
    assert_template 'shifts/edit'
  end

  test 'should update shift' do
    1.minute.ago.to_datetime.tap do |finish|
      assert_no_difference 'Shift.count' do
        put :update, id: @shift, shift: {
          finish: finish,
          description: 'Some shift',
          user_id: users(:administrator).id
        }
      end
      
      assert_redirected_to shifts_url
      assert_equal finish.to_i, @shift.reload.finish.to_i
    end 
  end

  test 'should update stale shift' do
    shift = shifts(:open_shift)
    session[:has_an_open_shift] = true

    5.hours.ago.to_datetime.tap do |finish|
      assert_no_difference 'Shift.count' do
        put :update, id: shift, shift: {
          finish: finish,
          description: 'Some shift',
          user_id: users(:administrator).id
        }
      end

      assert_redirected_to shifts_url
      assert_equal finish.to_i, shift.reload.finish.to_i
      assert !session[:has_an_open_shift]
    end
  end
  
  test 'should destroy shift' do
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @shift
    end

    assert_redirected_to shifts_url
  end

  test 'should pay a shift' do
    @shift = shifts(:old_shift)
    assert_difference 'Shift.pay_pending.count', -1 do
      put :update, id: @shift, shift: {
        paid: true,
        user_id: users(:administrator).id
      }
    end
  end

  test 'should get pay pending for user between dates' do
    from = 3.weeks.ago.to_date
    to = Time.zone.today
    user = users(:operator)
    shifts = user.shifts.pending_between(from, to)
    
    get :index, format: :json, pay_pending_shifts_for_user_between: {
      user_id: user.id, start: from.to_s(:db), finish: to.to_s(:db)
    }
    
    assert_response :success
    assert_not_nil assigns(:shifts)
    assert assigns(:shifts).size > 0
    assert_equal assigns(:shifts).sort, shifts.sort
  end
end

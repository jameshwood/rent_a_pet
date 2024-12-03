require "test_helper"

class AnimalsControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should get index" do
    get animals_index_url
    assert_response :success
  end
>>>>>>> master
end

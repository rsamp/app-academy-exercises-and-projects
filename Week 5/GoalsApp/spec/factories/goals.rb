FactoryGirl.define do
  factory :goal do
    description "Pass the test"
    privacy_status "private"
    completion_status "incomplete"
  end
end
# FactoryGirl.define do
#   factory :goal2 do
#     description "Finish the burrito"
#     privacy_status "public"
#     completion_status "complete"
#   end
# end

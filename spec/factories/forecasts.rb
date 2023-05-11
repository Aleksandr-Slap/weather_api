FactoryBot.define do
  factory :forecast do
    max { 12.9 }
    min { 4.3 }
    avg { 7.6 }
    history { [{"temp"=>"12.9", "time"=>"2023-04-21 13:00:00 +0300"},
               {"temp"=>"12.1", "time"=>"2023-04-21 12:00:00 +0300"},
               {"temp"=>"10.7", "time"=>"2023-04-21 11:00:00 +0300"}] } 
  end
end
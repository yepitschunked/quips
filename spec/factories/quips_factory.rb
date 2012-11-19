FactoryGirl.define do
  factory :quip do
    source 'a source'
    submitter 'a submitter'
    date { Time.zone.now }
    quip 'quip body'
  end
end

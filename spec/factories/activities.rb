FactoryBot.define do
  factory :activity do
    name { "salida al cine" }
    description { "Esta es una descripcion" }
    activity_type { "recreational_outlet" }
    location { "Cayala Zona 16" }
    budget { 1000 }
    start_date { "2022-06-02 19:00:00" }
    end_date { "2022-06-02 20:00:00" }
    access_level { "public" }
  end
end

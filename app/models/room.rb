class Room < ApplicationRecord
  scope :with_no_blue_lounge_chairs_working, lambda {
    join_sql = <<~SQL
      LEFT OUTER JOIN "chairs" "lounge_chairs_rooms" ON
        "lounge_chairs_rooms"."room_id" = "rooms"."id"
        AND "lounge_chairs_rooms"."type" = \'LoungeChair\'
    SQL
    joins(join_sql)
      .where('("lounge_chairs_rooms"."id" IS NULL OR "lounge_chairs_rooms"."color" != \'blue\')')
  }

  scope :with_no_red_swing_chairs_working, lambda {
    join_sql = <<~SQL
      LEFT OUTER JOIN "chairs" "swing_chairs_rooms" ON
        "swing_chairs_rooms"."room_id" = "rooms"."id"
        AND "swing_chairs_rooms"."type" = \'SwingChair\'
    SQL
    joins(join_sql)
      .where('("swing_chairs_rooms"."id" IS NULL OR "swing_chairs_rooms"."color" != \'red\')')
  }

  scope :with_no_blue_lounge_chairs_not_working, lambda {
    left_outer_joins(:lounge_chairs).where(chairs: { id: nil })
                                    .or(left_outer_joins(:lounge_chairs).where.not(chairs: { color: 'blue' }))
  }

  scope :with_no_red_swing_chairs_not_working, lambda {
    left_outer_joins(:swing_chairs).where(chairs: { id: nil })
                                   .or(left_outer_joins(:swing_chairs).where.not(chairs: { color: 'red' }))
  }

  has_many :swing_chairs
  has_many :lounge_chairs
end

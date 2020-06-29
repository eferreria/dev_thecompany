view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [state, city]
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    label: "({{_view._name}}) Gender"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
    drill_fields: [city]
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [-detail*, state, city, country]
  }

  drill_fields: []

  measure: total_orders_per_user {
    type: number
    sql: 1.0*${order_items.total_sales}${count} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      city,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
use weather;

delete from current_weather;

insert into current_weather
(
       station_id,
       station_city,
       station_state,
       station_lat,
       station_lon,
       as_of_dt,
       temp,
       feels_like,
       wind,
       wind_direction,
       precipitation,
       pressure,
       visibility,
       humidity,
       weather_desc,
       sunrise,
       sunset
)
select station_id,
       station_city,
       station_state,
       station_lat,
       station_lon,
       as_of_dt,
       temp,
       feels_like,
       wind,
       wind_direction,
       precipitation,
       pressure,
       visibility,
       humidity,
       weather_desc,
       sunrise,
       sunset
from   current_weather_load;

use weather;

delete from current_weather_load;

load data local infile 'weather.csv'
into table current_weather_load 
fields terminated by ','
(
	station_id,
	station_city,
	station_state,
	station_lat,
	station_lon,
	@aod,
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
set as_of_dt = str_to_date(@aod,'%Y%m%d %H:%i');

show warnings;

select concat('No data loaded for ',station_id,': ',station_city)
from   current_weather cw
where  cw.station_id not in
(
    select cwl.station_id
    from   current_weather_load cwl
);
CREATE TABLE grids (id integer primary key, ts timestamp default current_timestamp, remotehost varchar, input, size_x int, size_y int, simple tinyint, result varchar);

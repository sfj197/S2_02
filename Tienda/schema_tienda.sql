

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

select*from producto;

select nombre,precio from producto;

describe producto;

select nombre,precio,format(precio*1.10,2) as precio_dolares  from producto;
select nombre,precio as euros,format(precio*1.10,2) as dolares from producto;

select  upper(nombre),precio from producto;

select lower(nombre) ,precio from producto;

select nombre,left(upper(nombre),2) as caracteres from fabricante;

select nombre,precio,format(precio,0) as p_entero from producto;

select nombre,precio,truncate(precio,0) as sin_decimal from producto;

select  producto.codigo_fabricante from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo;

select distinct producto.codigo_fabricante from producto 
inner join fabricante on producto.codigo_fabricante = fabricante.codigo;

select fabricante.nombre from fabricante order by fabricante.nombre;

select fabricante.nombre from fabricante order by fabricante.nombre desc;

select producto.nombre,producto.precio from producto order by producto.nombre, producto.precio desc;

select*from fabricante limit 5;

select*from fabricante limit 3,2;

select producto.nombre,producto.precio from producto order by producto.precio limit 1;

select producto.nombre,producto.precio from producto order by producto.precio desc limit 1;

select producto.nombre from producto where codigo_fabricante = 2;

select producto.nombre,producto.precio,fabricante.nombre as fabricante from producto 
inner join fabricante on producto.codigo_fabricante = fabricante.codigo;

select producto.nombre,producto.precio,fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo order by fabricante.nombre;

select producto.codigo,producto.nombre,fabricante.codigo,fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante .codigo;

select producto.nombre,producto.precio,fabricante.nombre as fabricante from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
order by producto.precio limit 1;

select producto.nombre,producto.precio,fabricante.nombre as fabricante from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
order by producto.precio desc limit 1;

select*from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre = 'lenovo';

select * from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where producto.precio > 200 and fabricante.nombre = 'crucial';

select * from producto 
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre ='seagate' or fabricante.nombre = 'Hewlett-Packard' or fabricante.nombre = 'asus';

select * from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre in ('seagate','hewlett-packard','asus');

select * from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre like '%e';

select * from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre like '%w%';

select producto.nombre,producto.precio,fabricante.nombre from producto
inner join fabricante on producto.codigo_fabricante = fabricante.codigo
where producto.precio >=180 order by producto.precio desc,producto.nombre asc;

select  fabricante.codigo,fabricante.nombre from fabricante
inner join producto on fabricante.codigo = producto.codigo_fabricante;

select * from fabricante
left join producto on fabricante.codigo = producto.codigo_fabricante;

select * from fabricante
where fabricante.codigo not in( select producto.codigo_fabricante from producto);

select * from producto
where producto.codigo_fabricante = 2;

select * from producto
where precio = (select max(precio) from producto where codigo_fabricante = 2);

select * from producto
where producto.codigo_fabricante = 3 order by precio limit 1;

select * from producto
where producto.precio >= (select max(precio) from producto where producto.codigo_fabricante = 2);

select * from producto
where producto.codigo_fabricante = 1 and producto.precio > 
(select avg(precio) from producto where producto.codigo_fabricante = 1);
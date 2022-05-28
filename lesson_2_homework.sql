--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- 20.  Найдите средний размер hd PC каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD. (27)
select maker, avg(hd)
from pc
join product 
on product.model = pc.model
group by maker
having maker in (
select maker
from product
where type = 'printer'
)

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
select name, class
from ships 
where launched > 1920
--

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
select name, class
from ships 
where launched > 1920 and launched < 1942
--

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
select count(name), class 
from ships
group by class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes) (31)
select class, country
from classes
where bore >= 16;

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
select ship
from outcomes
where result = 'sunk' and battle = 'North Atlantic'



-- Задание 6: Вывести название (ship) последнего потопленного корабля
-- в подзапросе находим последнее сражение, в котором был потоплен корабль
-- в запросе находим все потопленные корабли с датой сражения из подзапроса
select distinct ship from battles b 
left join outcomes on outcomes.battle = b.name
where result = 'sunk' and date = (
	select max(date) from battles b 
	left join outcomes on outcomes.battle = b.name
	where result = 'sunk'
)

-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
-- аналогично предыдущему, но добавляем класс
select ship, class from battles b 
left join outcomes on outcomes.battle = b.name
left join ships s on s."name" = outcomes.ship 
where result = 'sunk' and date = (
	select max(date) from battles b 
	left join outcomes on outcomes.battle = b.name
	where result = 'sunk'
)

-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
select s."name"  from outcomes
left join ships s on s."name" = outcomes.ship 
left join classes c on c."class" = s."class" 
where c.bore >= 16 and outcomes.result = 'sunk'

-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
select class
from classes
where country = 'USA'


-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
select name, Ships.class
from Ships
join Classes
on Ships.class = Classes.class
where Classes.country = 'USA'


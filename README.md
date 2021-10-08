Решение задачи о поиске наибольшего квадрата на карте

---
Для генерации карты следует запустить скрипт map.pl
Скрипт принимает 3 аргумента: длина и ширина карты, плотность препятствий

perl map.pl 10 10 1

---
Для сборки файла BSQ - следует запустить Makefile

make

---
Программа принимает на вход от 1 до n карт и выводит результат в standart output.
Если программа не получила аргументы, то ввод карты происходит с клавиатуры. Ввод закончится после применения клавиш crtl + D
В случае обнаружения ошибки программа выведет map error


BSQ (Biggest SQuare)
Квадрат самой большой площади на карте
Цель этого проекта - найти квадрат самой большой площади на карте, избегая препятствий.

Будет предоставлен файл, содержащий карту. Это должно быть передано в качестве аргумента для вашей программы.

Первая строка карты содержит информацию о том, как читать карту:

количество линий на карте;
«пустой» символ;
символ «препятствие»;
«полный» символ.
Карта состоит из «пустых» символов, строк и символов «препятствий».

Цель программы - заменить «пустые» символы на «полные» символы, чтобы представить максимально возможный квадрат.

В случае, если существует более одного решения, мы выберем представление квадрата, который находится ближе всего к верхней части карты, а затем квадрата, который расположен наиболее слева.

Определение действительной карты:

Все строки должны иметь одинаковую длину.
Есть хотя бы одна строка хотя бы из одной рамки.
На каждом конце строки есть разрыв строки.
Символы на карте могут быть только теми, которые введены в первой строке.
В случае неверной карты ваша программа должна отобразить ошибку карты в выводе ошибки с последующим переводом строки. Ваша программа перейдет к следующей карте
Вот пример того, как это должно работать:
	%>cat example_file
	9.ox
	...........................
	....o......................
	............o..............
	...........................
	....o......................
	...............o...........
	...........................
	......o..............o.....
	..o.......o................

	%>./bsq example_file
	.....xxxxxxx...............
	....oxxxxxxx...............
	.....xxxxxxxo..............
	.....xxxxxxx...............
	....oxxxxxxx...............
	.....xxxxxxx...o...........
	.....xxxxxxx...............
	......o..............o.....
	..o.......o................
	%>
Это действительно квадрат. Хотя он может и не выглядеть внешне как квадрат из-за разного растояния между символами и строками.

Инструкции
Исполняемый файл должен называться bsq и присутствовать в главном каталоге.

Вы должны уважать нормы написания кода.

Вы можете использовать только методы, изученные во время Piscine C.

В каталоге отправки должен быть файл автора, содержащий ваши логины:

	$>cat auteur
	login_1:login_2
	$>
Ваша программа должна обрабатывать от 1 до n файлов в качестве параметров.

Если обрабатываются более 1 файла то, результат должен быть отделен друг от друга пустой строкой.

Когда ваша программа получает более одной карты в качестве аргумента, каждое решение или ошибка должны опровождаться переводом строки.

Если не будет переданных аргументов, ваша программа должна быть в состоянии читать на стандартный ввод.

У вас должен быть действующий Makefile, который скомпилирует ваш проект.

Вы можете использовать только следующие функции: exit, open, close, write, read, malloc и free.

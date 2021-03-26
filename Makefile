check_first_line.c                                                                                  000644  035752  010175  00000003737 14022224302 013750  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   check_first_line.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/10 12:18:33 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:14:58 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

void			ft_check_symbols(t_fline *args, int i, int l)
{
	int shift;

	shift = 2 - i;
	while (i + shift > -1 && l > 4)
	{
		if (i < 0)
		{
			args->symbols[i + shift] = args->height % 10 + '0';
			args->height = args->height / 10;
		}
		else
			args->symbols[i + shift] = args->symbols[i];
		i--;
	}
}

t_fline			*ft_create_struct(int *i, int *l, int fd, char *buff)
{
	t_fline	*args;

	args = malloc(sizeof(t_fline));
	buff[0] = 0;
	args->height = 0;
	while (buff[0] != '\n' && *i < 3)
	{
		read(fd, buff, 1);
		if (buff[0] >= '0' && buff[0] <= '9' && *i == -1)
			args->height = args->height * 10 + (buff[0] - '0');
		else if (buff[0] != '\n')
			args->symbols[++(*i)] = buff[0];
		*l = *l + 1;
	}
	return (args);
}

t_fline			*ft_first_line(int fd)
{
	int		i;
	int		l;
	char	buff[1];
	t_fline	*args;

	i = -1;
	l = 0;
	args = ft_create_struct(&i, &l, fd, buff);
	ft_check_symbols(args, i, l);
	if (buff[0] != '\n' || args->symbols[0] == args->symbols[1] ||
	args->symbols[1] == args->symbols[2] ||
	args->symbols[0] == args->symbols[2])
	{
		free(args);
		close(fd);
		return (NULL);
	}
	return (args);
}
                                 draw_map.c                                                                                          000644  035752  010175  00000004103 14022224314 012236  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   draw_map.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/10 23:12:43 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:15:08 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

void	ft_read_from_file(int fd, int size, char *buff)
{
	int i;

	while (size > 30000)
	{
		i = read(fd, buff, 30000);
		write(1, &buff[0], i);
		size -= 30000;
	}
	i = read(fd, buff, size);
	write(1, &buff[0], i);
}

void	ft_print_not_zero_map(unsigned int *res, int arr[2],
char *buff, char symbol)
{
	int				i;
	char			*line;
	int				size;

	line = malloc(sizeof(char) * res[2]);
	i = -1;
	size = res[0] * (arr[0] + 1) + res[1];
	while ((unsigned int)++i < res[2])
		line[i] = symbol;
	ft_read_from_file(arr[1], size, buff);
	i = -1;
	while ((unsigned int)++i < res[2])
	{
		read(arr[1], buff, res[2]);
		write(1, &line[0], res[2]);
		size = (arr[0] + 1) - res[2];
		ft_read_from_file(arr[1], size, buff);
	}
	free(line);
}

void	ft_drawmap(char *file, unsigned int *res, int w, char symbol)
{
	int				fd;
	char			*buff;
	int				i;
	int				arr[2];

	buff = malloc(sizeof(char) * 30000);
	fd = open(file, O_RDONLY);
	i = -1;
	buff[0] = 0;
	arr[0] = w;
	arr[1] = fd;
	while (buff[0] != '\n')
		read(fd, buff, 1);
	if (res[2] != 0)
		ft_print_not_zero_map(res, arr, buff, symbol);
	i = read(fd, buff, 30000);
	while (i)
	{
		write(1, &buff[0], i);
		i = read(fd, buff, 30000);
	}
	free(buff);
	close(fd);
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                             ft.h                                                                                                000644  035752  010175  00000004215 14022225537 011076  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft.h                                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/10 12:21:04 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:26:07 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_H
# define FT_H
# include <unistd.h>
# include <stdio.h>
# include <fcntl.h>
# include <stdlib.h>
# include <stdio.h>

typedef struct	s_fline
{
	char	symbols[3];
	int		height;
}				t_fline;
typedef struct	s_lines
{
	unsigned int	*line;
	unsigned int	*line2;
	int				lenght;
}				t_lines;
int				ft_error(void *data);
unsigned int	ft_min(unsigned int a, unsigned int b);
void			ft_arg_to_array(unsigned int *arr, int a, int b, int c);
int				ft_wtfl(t_lines *lines, char *fl_buff,
char *symbols, unsigned int *res);
int				ft_write_line2(int arr[2], t_lines *lines,
unsigned int *res, char *symbols);
unsigned int	*ft_write_in_line(int arr[2], t_lines *lines, char *symbols,
unsigned int *res);
int				ft_run_to_map(t_fline *args, t_lines *lines,
int fd, unsigned int *res);
int				ft_read_first_map_line(char *fl_buff, int fd, t_lines *lines);
t_lines			*first_map_line(int fd, char *symbols, unsigned int *res);
void			ft_read_from_file(int fd, int size, char *buff);
void			ft_print_not_zero_map(unsigned int *res, int arr[2],
char *buff, char symbol);
void			ft_drawmap(char *file, unsigned int *res, int w, char symbol);
t_fline			*ft_first_line(int fd);
t_fline			*ft_create_struct(int *i, int *l, int fd, char *buff);
void			ft_check_symbols(t_fline *args, int i, int l);

#endif
                                                                                                                                                                                                                                                                                                                                                                                   main.c                                                                                              000644  035752  010175  00000003657 14022227244 011412  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/09 11:56:34 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:40:04 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

void			ft_run_map_task(char *file)
{
	int				fd;
	t_fline			*args;
	t_lines			*lines;
	unsigned int	res[3];

	fd = open(file, O_RDONLY);
	if (fd == -1)
	{
		write(2, "map error\n", 10);
		return ;
	}
	args = ft_first_line(fd);
	if (ft_error(args) == 0)
		return ;
	res[2] = 0;
	lines = first_map_line(fd, args->symbols, res);
	if (ft_error(lines) == 0)
		return ;
	if (ft_run_to_map(args, lines, fd, res) == 0)
		return ;
	close(fd);
	ft_drawmap(file, res, lines->lenght, args->symbols[2]);
}

void    ft_new_file(void)
{
    int     fd;
    char    buf;
    fd = open("map.txt", O_CREAT | O_RDONLY | O_WRONLY, 0600);
    while (read(0, &buf, 1))
        write(fd, &buf, 1);
    write(fd, "\n", 1);
    close(fd);
}

void    check_wr(void)
{
    if (write(1, "", 0) < 0)
        write(2, "error\n", 6);
}

int     main(int argc, char **argv)
{
    int i;
    i = 0;
    check_wr();
    if (argc == 1)
    {
        ft_new_file();
        ft_run_map_task("map.txt");
    }
    while (++i < argc)
    {
        ft_run_map_task(argv[i]);
    }
    return (0);
}                                                                                 prepare.c                                                                                           000644  035752  010175  00000004103 14022225127 012105  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   prepare.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/10 23:20:41 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:21:43 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

int				ft_wtfl(t_lines *lines, char *fl_buff,
char *symbols, unsigned int *res)
{
	int i;

	i = -1;
	while (++i < lines->lenght + 1)
	{
		if (fl_buff[i] == symbols[1])
			lines->line[i] = 0;
		else if (fl_buff[i] == symbols[0])
		{
			lines->line[i] = 1;
			if (res[2] == 0)
				ft_arg_to_array(res, 0, i, 1);
		}
		else
			break ;
	}
	free(fl_buff);
	if (i == -1)
	{
		free(lines->line);
		free(lines);
	}
	return (i);
}

int				ft_read_first_map_line(char *fl_buff, int fd, t_lines *lines)
{
	int		i;
	char	buff[1];

	i = -1;
	while (read(fd, buff, 1) && buff[0] != '\n')
		fl_buff[++i] = buff[0];
	lines = NULL;
	if (i == -1)
	{
		close(fd);
		free(fl_buff);
	}
	return (i);
}

t_lines			*first_map_line(int fd, char *symbols, unsigned int *res)
{
	char	*fl_buff;
	int		i;
	t_lines	*lines;

	lines = NULL;
	fl_buff = malloc(sizeof(char) * 10000);
	i = ft_read_first_map_line(fl_buff, fd, lines);
	if (i == -1)
		return (NULL);
	lines = malloc(sizeof(t_lines));
	lines->line = malloc(sizeof(int) * (i + 1));
	lines->lenght = i;
	i = ft_wtfl(lines, fl_buff, symbols, res);
	if (i == -1)
	{
		close(fd);
		return (NULL);
	}
	lines->line2 = malloc(sizeof(int) * (i));
	lines->lenght = i;
	return (lines);
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                             run_map.c                                                                                           000644  035752  010175  00000004227 14022225564 012124  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   run_map.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/10 23:23:58 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:26:28 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

int				ft_write_line2(int arr[2], t_lines *lines,
unsigned int *res, char *symbols)
{
	int		i;
	char	buff[1];

	i = 0;
	while (read(arr[1], buff, 1) && buff[0] != '\n')
	{
		if (buff[0] == symbols[1])
			lines->line2[i] = 0;
		else if (buff[0] == symbols[0])
		{
			if (i == 0)
				lines->line2[i] = 1;
			else
				lines->line2[i] = ft_min(ft_min(lines->line2[i - 1],
				lines->line[i]), lines->line[i - 1]) + 1;
			if (lines->line2[i] > res[2])
				ft_arg_to_array(res, arr[0] - lines->line2[i] + 1,
				i - lines->line2[i] + 1, lines->line2[i]);
		}
		else
			return (-1);
		i++;
	}
	return (i);
}

unsigned int	*ft_write_in_line(int arr[2], t_lines *lines, char *symbols,
unsigned int *res)
{
	int		i;

	i = ft_write_line2(arr, lines, res, symbols);
	if (i == 0 || i != lines->lenght)
	{
		close(arr[1]);
		free(lines->line);
		free(lines->line2);
		free(lines);
		return (NULL);
	}
	return (lines->line2);
}

int				ft_run_to_map(t_fline *args, t_lines *lines,
int fd, unsigned int *res)
{
	int				i;
	unsigned int	*temp;
	int				arr[2];

	i = 0;
	while (++i < args->height)
	{
		temp = lines->line;
		arr[0] = i;
		arr[1] = fd;
		lines->line = ft_write_in_line(arr, lines, args->symbols, res);
		lines->line2 = temp;
		if (ft_error(lines->line) == 0)
			return (0);
	}
	return (1);
}
                                                                                                                                                                                                                                                                                                                                                                         standar.c                                                                                           000644  035752  010175  00000002273 14022225446 012115  0                                                                                                    ustar 00tdina                                                           000000  000000                                                                                                                                                                         /* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   standar.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdina <tdina@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/10 23:18:16 by tdina             #+#    #+#             */
/*   Updated: 2021/03/10 23:25:10 by tdina            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

unsigned int	ft_min(unsigned int a, unsigned int b)
{
	return (a < b ? a : b);
}

void			ft_arg_to_array(unsigned int *arr, int a, int b, int c)
{
	arr[0] = a;
	arr[1] = b;
	arr[2] = c;
}

int		ft_error(void *data)
{
	if (data == NULL)
	{
		write(2, "map error\n", 10);
		return (0);
	}
	return (1);
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
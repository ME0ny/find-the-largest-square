/* ************************************************************************** */
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

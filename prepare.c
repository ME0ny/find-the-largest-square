/* ************************************************************************** */
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
		{
			i = -1;
			break ;
		}
	}
	free(fl_buff);
	if (i == -1)
	{
		free(lines->line);
		free(lines);
	}
	return (i);
}

int				ft_read_first_map_line(char *fl_buff, int fd)
{
	int		i;
	char	buff[1];

	i = -1;
	while (read(fd, buff, 1) && buff[0] != '\n')
		fl_buff[++i] = buff[0];
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
	i = ft_read_first_map_line(fl_buff, fd);
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

/* ************************************************************************** */
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

/* ************************************************************************** */
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

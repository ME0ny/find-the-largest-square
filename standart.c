/* ************************************************************************** */
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

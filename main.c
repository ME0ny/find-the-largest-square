/* ************************************************************************** */
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
    fd = open("map.txt", O_CREAT | O_WRONLY, 0600);
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
}
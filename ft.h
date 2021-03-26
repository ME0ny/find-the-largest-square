/* ************************************************************************** */
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
int				ft_read_first_map_line(char *fl_buff, int fd);
t_lines			*first_map_line(int fd, char *symbols, unsigned int *res);
void			ft_read_from_file(int fd, int size, char *buff);
void			ft_print_not_zero_map(unsigned int *res, int arr[2],
char *buff, char symbol);
void			ft_drawmap(char *file, unsigned int *res, int w, char symbol);
t_fline			*ft_first_line(int fd);
t_fline			*ft_create_struct(int *i, int *l, int fd, char *buff);
void			ft_check_symbols(t_fline *args, int i, int l);

#endif

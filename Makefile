# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ypringau <ypringau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/12/12 10:58:13 by ypringau          #+#    #+#              #
#    Updated: 2014/01/17 13:12:08 by ypringau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = clang
CFLAGS = -Wextra -Wall -Werror -I./includes
DEBUG = -g3 -fno-inline -DD_ERRORS_ON
LIB = -I libft/includes
LDFLAGS = -L libft -lft
OBJDIR  = .objs
LISTDIR = srcs
DIRSRC = srcs
NAME = 
SRC = $(DIRSRC)/main.c
OBJ = $(addprefix $(OBJDIR)/, $(SRC:.c=.o))

.SILENT:

$(addprefix $(OBJDIR)/, %.o): %.c
	$(CC) $(CFLAGS) -o $@ -c $< $(LIB)
	printf '\033[0;32mBuilding C Object $@\n\033[0m' "Building C Object $@"

all: lib $(NAME)

$(NAME): $(OBJDIR) $(OBJ)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJ) $(LDFLAGS)
	printf '\033[1;31m%s \033[1;35m%s \033[1;31m%s \033[1;33m%s\n\033[0m' \
		"Linking C executable" "$(NAME)" "with" "$(CC)"

lib:
	$(MAKE) -C libft

clean:
	$(MAKE) -C libft $@
	/bin/rm -fr $(OBJDIR)
	printf '\033[1;34m%s\n\033[0m' "Clean project $(NAME)"

test: CFLAGS = -Wall
test: re

debug: CFLAGS += $(DEBUG)
debug: re
	printf '\033[1;31m%s \033[1;35m%s\n\033[0m' "Debug version" "$(DEBUG)"

analyze: CFLAGS += --analyze
analyze: re

every: CFLAGS += -Weverything
every: re
	printf '\033[1;33m%s\n\033[0m' "Good job !"

fclean: clean
	$(MAKE) -C libft $@
	/bin/rm -fr $(NAME)
	printf '\033[1;34m%s\n\033[0m' "Fclean project $(NAME)"

re: fclean all

$(OBJDIR):
	/bin/mkdir $(OBJDIR);            \
	for DIR in $(LISTDIR);           \
	do                               \
		/bin/mkdir $(OBJDIR)/$$DIR;  \
	done                             \

.PHONY: clean fclean re

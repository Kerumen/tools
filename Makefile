# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ypringau <ypringau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/12/12 10:58:13 by ypringau          #+#    #+#              #
#    Updated: 2014/01/22 11:57:28 by ypringau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL = bash
UNAME = $(shell uname -s)
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
ifeq ($(UNAME), Darwin)
	printf '\033[0;32mBuilding C Object $@\n\033[0m' "Building C Object $@"
else
	echo -e '\033[0;32mBuilding C Object $@\n\033[0m' "Building C Object $@"
endif

all: lib $(NAME)

$(NAME): $(OBJDIR) $(OBJ)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJ) $(LDFLAGS)
ifeq ($(UNAME), Darwin)
	printf '\033[1;31m%s \033[1;35m%s \033[1;31m%s \033[1;33m%s\n\033[0m' \
		"Linking C executable" "$(NAME)" "with" "$(CC)"
else
	echo -e '\033[1;31m%s \033[1;35m%s \033[1;31m%s \033[1;33m%s\n\033[0m' \
		"Linking C executable" "$(NAME)" "with" "$(CC)"
endif

lib:
	$(MAKE) -C libft

clean:
	$(MAKE) -C libft $@
	/bin/rm -fr $(OBJDIR)
ifeq ($(UNAME), Darwin)
	printf '\033[1;34m%s\n\033[0m' "Clean project $(NAME)"
else
	echo -e '\033[1;34m%s\n\033[0m' "Clean project $(NAME)"
endif

test: CFLAGS = -Wall
test: re

debug: CFLAGS += $(DEBUG)
debug: re
ifeq ($(UNAME), Darwin)
	printf '\033[1;31m%s \033[1;35m%s\n\033[0m' "Debug version" "$(DEBUG)"
else
	echo -e '\033[1;31m%s \033[1;35m%s\n\033[0m' "Debug version" "$(DEBUG)"
endif

analyze: CFLAGS += --analyze
analyze: re

every: CFLAGS += -Weverything
every: re
ifeq ($(UNAME), Darwin)
	printf '\033[1;33m%s\n\033[0m' "Good job !"
else
	echo -e '\033[1;33m%s\n\033[0m' "Good job !"
endif

fclean: clean
	$(MAKE) -C libft $@
	/bin/rm -fr $(NAME)
ifeq ($(UNAME), Darwin)
	printf '\033[1;34m%s\n\033[0m' "Fclean project $(NAME)"
else
	echo -e '\033[1;34m%s\n\033[0m' "Fclean project $(NAME)"
endif

re: fclean all

$(OBJDIR):
	/bin/mkdir $(OBJDIR);            \
	for DIR in $(LISTDIR);           \
	do                               \
		/bin/mkdir $(OBJDIR)/$$DIR;  \
	done                             \

.PHONY: clean fclean re

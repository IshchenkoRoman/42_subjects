# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: clabouri <clabouri@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/09/13 18:16:35 by clabouri          #+#    #+#              #
#    Updated: 2017/09/14 12:04:53 by clabouri         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=	rush01

O1		=	\033[0;38;5;166m
O2		=	\033[0;2;38;5;166m
G1		=	\033[0;38;5;82m
G2		=	\033[0;2;38;5;82m
R		=	\033[0m

MK		=	/bin/mkdir -p
RM		=	/bin/rm -f

SRC		=	$(shell find . -name "*.c")
INCS	=	$(shell find . -name "*.h")
INC		=	$(addprefix -I,$(sort $(dir $(INCS))))

OBJ		=	$(SRC:.c=.o)

UDIR	=	.unit

CC		=	/usr/bin/clang
CFLAG	=	-Wall -Werror -Wextra $(INC)
COMP	=	$(CC) $(CFLAG)

FEXP	=	's/[1-9][0-9]*/\\\033[31mNorm Error/'
OEXP	=	's/^0/\\\033[32mNorm Ok/'
SEDN	=	sed -E -e 's/ //g' -e $(FEXP) -e $(OEXP)
NORM	=	norminette | grep Error | wc -l | $(SEDN)

FAIL	=	's/[1-9]+/\\\033[0;31mX/'
SUCC	=	's/^0/\\\033[0;32mO/'
SEDD	=	sed -E -e 's/ //g' -e $(FAIL) -e $(SUCC)
DIFF	=	wc -l | $(SEDD)

.SILENT:
all: norm $(NAME) $(UDIR) user malloc advanced

$(NAME): $(OBJ)
	echo "\n$(O1)Compiling [$(O2)$@$(O1)]$(R)"
	$(COMP) -o $@ $(OBJ)
	echo "\033[A\033[K$(G1)Compiled  [$(G2)$@$(G1)]$(R)"

%.o:%.c
	echo "$(O1)Compiling [$(O2)$(notdir $(basename $@))$(O1)]$(R)"
	$(COMP) -o $@ -c $<
	echo "\033[A\033[K$(G1)Compiled  [$(G2)$(notdir $(basename $@))$(G1)]$(R)"


norm:
	echo "Checking norm..."
	echo "`$(NORM)`$(R)\n"

$(UDIR):
	echo "\nGenerating files for unit tests..."
	$(MK) $(UDIR)
	echo "$(G1)Created directory [$(G2)$(UDIR)$(G1)]$(R)"
	echo "Error" > $(UDIR)/e_error
	echo "$(G1)Created unit test file [$(G2)e_error$(G1)]$(R)"
	echo "9 1 4 3 7 5 2 6 8\n\
	2 8 7 4 9 6 1 5 3\n\
	3 6 5 8 1 2 4 7 9\n\
	8 4 6 5 2 1 3 9 7\n\
	5 2 9 6 3 7 8 1 4\n\
	7 3 1 9 8 4 5 2 6\n\
	1 5 3 7 4 9 6 8 2\n\
	6 9 8 2 5 3 7 4 1\n\
	4 7 2 1 6 8 9 3 5" > $(UDIR)/e_subject
	echo "$(G1)Created unit test file [$(G2)e_subject$(G1)]$(R)"
	echo "8 2 4 6 3 5 9 7 1\n\
	3 1 5 7 4 9 2 6 8\n\
	6 7 9 1 2 8 3 4 5\n\
	7 9 6 8 5 1 4 2 3\n\
	2 5 1 3 9 4 6 8 7\n\
	4 3 8 2 6 7 1 5 9\n\
	1 8 2 4 7 3 5 9 6\n\
	9 4 3 5 8 6 7 1 2\n\
	5 6 7 9 1 2 8 3 4" > $(UDIR)/e_easy
	echo "$(G1)Created unit test file [$(G2)e_easy$(G1)]$(R)"
	echo "6 2 3 7 9 1 8 4 5\n\
	4 5 8 3 2 6 9 1 7\n\
	1 9 7 4 5 8 2 3 6\n\
	7 8 9 5 1 2 4 6 3\n\
	2 3 4 6 8 7 5 9 1\n\
	5 6 1 9 4 3 7 8 2\n\
	3 4 6 2 7 9 1 5 8\n\
	9 1 2 8 6 5 3 7 4\n\
	8 7 5 1 3 4 6 2 9" > $(UDIR)/e_easy2
	echo "$(G1)Created unit test file [$(G2)e_easy2$(G1)]$(R)"
	echo "3 1 7 4 6 2 5 9 8\n\
	6 2 4 9 5 8 3 7 1\n\
	5 9 8 7 1 3 6 4 2\n\
	4 8 9 2 3 6 1 5 7\n\
	1 3 2 5 7 4 9 8 6\n\
	7 6 5 1 8 9 2 3 4\n\
	2 4 3 8 9 1 7 6 5\n\
	9 5 1 6 4 7 8 2 3\n\
	8 7 6 3 2 5 4 1 9" > $(UDIR)/e_med
	echo "$(G1)Created unit test file [$(G2)e_med$(G1)]$(R)"
	echo "9 5 2 8 3 1 4 6 7\n\
	3 1 7 6 2 4 5 8 9\n\
	8 4 6 5 9 7 1 2 3\n\
	5 2 1 7 6 8 3 9 4\n\
	4 8 9 3 5 2 6 7 1\n\
	6 7 3 1 4 9 8 5 2\n\
	2 9 5 4 1 6 7 3 8\n\
	7 6 4 9 8 3 2 1 5\n\
	1 3 8 2 7 5 9 4 6" > $(UDIR)/e_med2
	echo "$(G1)Created unit test file [$(G2)e_med2$(G1)]$(R)"
	echo "1 8 6 3 4 7 9 2 5\n\
	9 7 5 6 2 1 3 8 4\n\
	4 3 2 9 8 5 6 7 1\n\
	3 1 4 7 6 8 5 9 2\n\
	2 6 9 5 1 4 7 3 8\n\
	7 5 8 2 9 3 1 4 6\n\
	8 4 7 1 3 6 2 5 9\n\
	6 9 3 8 5 2 4 1 7\n\
	5 2 1 4 7 9 8 6 3" > $(UDIR)/e_hard
	echo "$(G1)Created unit test file [$(G2)e_hard$(G1)]$(R)"
	echo "3 6 1 4 9 5 8 7 2\n\
	5 8 2 7 1 3 9 6 4\n\
	7 4 9 6 2 8 3 1 5\n\
	9 5 4 1 7 2 6 8 3\n\
	6 7 8 5 3 9 4 2 1\n\
	2 1 3 8 4 6 5 9 7\n\
	8 3 6 2 5 7 1 4 9\n\
	1 2 5 9 8 4 7 3 6\n\
	4 9 7 3 6 1 2 5 8" > $(UDIR)/e_hard2
	echo "$(G1)Created unit test file [$(G2)e_hard2$(G1)]$(R)"
	echo "3 8 7 2 4 9 1 5 6\n\
	5 4 1 6 3 8 2 9 7\n\
	9 6 2 1 7 5 3 8 4\n\
	8 7 4 5 2 3 6 1 9\n\
	2 1 5 9 6 4 7 3 8\n\
	6 9 3 7 8 1 4 2 5\n\
	1 3 8 4 9 7 5 6 2\n\
	4 2 9 3 5 6 8 7 1\n\
	7 5 6 8 1 2 9 4 3" > $(UDIR)/e_evil
	echo "$(G1)Created unit test file [$(G2)e_evil$(G1)]$(R)"
	echo "2 6 4 1 8 7 9 3 5\n\
	1 8 9 4 5 3 7 6 2\n\
	7 5 3 2 9 6 8 1 4\n\
	6 1 7 5 2 9 3 4 8\n\
	4 3 8 7 6 1 2 5 9\n\
	5 9 2 3 4 8 6 7 1\n\
	3 4 6 9 1 2 5 8 7\n\
	9 7 5 8 3 4 1 2 6\n\
	8 2 1 6 7 5 4 9 3" > $(UDIR)/e_evil2
	echo "$(G1)Created unit test file [$(G2)e_evil2$(G1)]$(R)"
	echo "9 1 3 7 2 4 6 5 8\n\
	2 4 7 5 6 8 9 3 1\n\
	6 8 5 9 1 3 7 2 4\n\
	1 6 9 3 7 2 4 8 5\n\
	5 7 8 4 9 1 2 6 3\n\
	3 2 4 6 8 5 1 7 9\n\
	4 5 2 1 3 7 8 9 6\n\
	7 9 1 8 5 6 3 4 2\n\
	8 3 6 2 4 9 5 1 7" > $(UDIR)/e_evil3
	echo "$(G1)Created unit test file [$(G2)e_evil3$(G1)]$(R)\n"

user:
	read -p "Press enter to start tests:"
	echo "Testing error handling..."
	$(shell ./$(NAME) "9...7...." "2...9..53" ".6..124.." "84...1.9." "5....8.." ".31..4..." "..37..68.." ".9..5.741" "47......." >&$(UDIR)/u_error1)
	echo `diff $(UDIR)/e_error $(UDIR)/u_error1 | $(DIFF)`"\c"
	$(shell ./$(NAME) "9...7...." "2...9..53" ".6..124.." "84...1.9." "5.....8.." ".31..4..." "..37..68." ".9..5.741" "48......." >&$(UDIR)/u_error2)
	echo `diff $(UDIR)/e_error $(UDIR)/u_error2 | $(DIFF)`"\c"
	$(shell ./$(NAME) "9...7...." "2...9..53" ".6..124.." "84...1.9." "5.....8.." ".31..4..." "........." ".9..5.741" "47......." >&$(UDIR)/u_error3)
	echo `diff $(UDIR)/e_error $(UDIR)/u_error3 | $(DIFF)`"\c"
	$(shell ./$(NAME) "9...7...." "2...9..53" ".6..124.." "84...1.9." "5.....8.." ".31..4..." "153749682" >&$(UDIR)/u_error4)
	echo `diff $(UDIR)/e_error $(UDIR)/u_error4 | $(DIFF)`"$(R)"
	read -p "Press enter to continue:"
	echo "Testing grid from subject..."
	$(shell ./$(NAME) "9...7...." "2...9..53" ".6..124.." "84...1.9." "5.....8.." ".31..4..." "..37..68." ".9..5.741" "47......." > $(UDIR)/u_subject)
	echo `diff $(UDIR)/e_subject $(UDIR)/u_subject | $(DIFF)`"$(R)"
	read -p "Press enter to continue:"
	echo "Testing different difficulties [easy-medium-hard-evil]..."
	$(shell ./$(NAME) "8246.5..." "..57.926." "...1...45" "79.8....." "2..3.4..7" ".....7.59" "18...3..." ".435.67.." "...9.2834" > $(UDIR)/u_easy)
	echo "Easy: "`diff $(UDIR)/e_easy $(UDIR)/u_easy | $(DIFF)`"\c"
	$(shell ./$(NAME) "62.....45" ".5.32..1." "...4.8..." "78.5.2.63" "..4.8.5.." "56.9.3.82" "...2.9..." ".1..65.7." "87.....29" > $(UDIR)/u_easy2)
	echo `diff $(UDIR)/e_easy2 $(UDIR)/u_easy2 | $(DIFF)`"$(R)"
	$(shell ./$(NAME) "3.74...9." "6.....371" ".....3..." "4.92....." "132.7.986" ".....92.4" "...8....." "951.....3" ".7...54.9" > $(UDIR)/u_med)
	echo "Medium: "`diff $(UDIR)/e_med $(UDIR)/u_med | $(DIFF)`"\c"
	$(shell ./$(NAME) "95..31.6." ".1....5.9" ".4.5....." "..1.683.." "........." "..314.8.." ".....6.3." "7.4....1." ".3.27..46" > $(UDIR)/u_med2)
	echo `diff $(UDIR)/e_med2 $(UDIR)/u_med2 | $(DIFF)`"$(R)"
	$(shell ./$(NAME) "..634.9.5" ".......8." ".....5..1" "..4.6...2" ".69.1.73." "7...9.1.." "8..1....." ".9......." "5.1.798.." > $(UDIR)/u_hard)
	echo "Hard: "`diff $(UDIR)/e_hard $(UDIR)/u_hard | $(DIFF)`"\c"
	$(shell ./$(NAME) "3..49...." ".82......" "7......15" "..417268." "........." ".138465.." "83......9" "......73." "....61..8" > $(UDIR)/u_hard2)
	echo `diff $(UDIR)/e_hard2 $(UDIR)/u_hard2 | $(DIFF)`"$(R)"
	$(shell ./$(NAME) "......1.6" ".41....9." "9...7...4" "..4.23..." ".15...73." "...78.4.." "1...9...2" ".2....87." "7.6......" > $(UDIR)/u_evil)
	echo "Evil: "`diff $(UDIR)/e_evil $(UDIR)/u_evil | $(DIFF)`"\c"
	$(shell ./$(NAME) ".6.1..9.." "....5...2" "...2....4" "61.5..3.." ".3..6..5." "..2..8.71" "3....2..." "9...3...." "..1..5.9." > $(UDIR)/u_evil2)
	echo `diff $(UDIR)/e_evil2 $(UDIR)/u_evil2 | $(DIFF)`"\c"
	$(shell ./$(NAME) ".1...4..." "...5..9.." "68..1..2." "......48." "578...263" ".24......" ".5..3..96" "..1..6..." "...2...1." > $(UDIR)/u_evil3)
	echo `diff $(UDIR)/e_evil3 $(UDIR)/u_evil3 | $(DIFF)`"$(R)"

malloc:
	read -p "Press enter to continue:"
	echo "Grepping malloc with 3 line range..."
	echo `/usr/bin/grep -n2 malloc $(SRC)`

advanced:
	read -p "Press enter to continue:"
	echo "Multiple solutions:"
	$(shell ./$(NAME) "9...7...." "2...9..53" ".6..124.." "84...1.9." "5.....8.." ".31..4..." "........." ".9..5.741" "47......." >&$(UDIR)/u_error5)
	echo `diff $(UDIR)/e_error $(UDIR)/u_error5 | $(DIFF)`"$(R)"
	read -p "Press enter to continue:"
	echo "User output for full correct grid (Expected nothing or the grid):"
	./$(NAME) "914375268" "287496153" "365812479" "846521397" "529637814" "731984526" "153749682" "698253741" "472168935" | cat
	read -p "Press enter to continue:"
	echo "User output for full uncorrect grid:"
	$(shell ./$(NAME) "914375268" "287496153" "365812479" "846521397" "529637814" "731984526" "153749682" "698253742" "472168935" >&$(UDIR)/u_error6)
	echo `diff $(UDIR)/e_error $(UDIR)/u_error6 | $(DIFF)`"$(R)"
	echo "Finished"

clean:
	$(RM) $(OBJ)
	$(RM) -r $(UDIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: user malloc advanced clean fclean all re

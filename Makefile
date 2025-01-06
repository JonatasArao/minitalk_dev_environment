TARGET = minitalk
SERVER_NAME = server
CLIENT_NAME = client
BIN_DIR = build

CC = cc
CFLAGS = -Wall -Wextra -Werror -g
LDFLAGS = -L$(LIBFT_DIR) -lft
LIBFT_DIR = $(TARGET)/libft
LIBFT_LIB = $(LIBFT_DIR)/libft.a

MINITALK_DIR = $(TARGET)/mandatory

HEADER_DIR = $(MINITALK_DIR)/inc
HEADER = $(HEADER_DIR)/minitalk.h
INCLUDES = -I$(HEADER_DIR) -I$(LIBFT_DIR)

SRC_DIR = $(MINITALK_DIR)/src

SERVER_DIR = $(SRC_DIR)/server
SERVER_FILES = main.c
SERVER_SRCS = $(addprefix $(SERVER_DIR)/, $(SERVER_FILES))

CLIENT_DIR = $(SRC_DIR)/client
CLIENT_FILES = main.c
CLIENT_SRCS = $(addprefix $(CLIENT_DIR)/, $(CLIENT_FILES))

OBJS_DIR = $(MINITALK_DIR)/objs
SERVER_OBJS = $(addprefix $(OBJS_DIR)/server_, $(SERVER_FILES:.c=.o))
CLIENT_OBJS = $(addprefix $(OBJS_DIR)/client_, $(CLIENT_FILES:.c=.o))

all: $(BIN_DIR)/$(SERVER_NAME) \
	 $(BIN_DIR)/$(CLIENT_NAME)

clean:
	rm -rf $(SERVER_OBJS) $(CLIENT_OBJS) $(OBJS_DIR)
	@make clean -C $(LIBFT_DIR)

fclean: clean
	rm -rf $(BIN_DIR) $(LIBFT_LIB)

re: fclean all

$(BIN_DIR)/$(SERVER_NAME): $(LIBFT_LIB) $(SERVER_OBJS) | $(BIN_DIR)
	$(CC) $(CFLAGS) $(SERVER_OBJS) $(LDFLAGS) -o $(BIN_DIR)/$(SERVER_NAME)

$(BIN_DIR)/$(CLIENT_NAME): $(LIBFT_LIB) $(CLIENT_OBJS) | $(BIN_DIR)
	$(CC) $(CFLAGS) $(CLIENT_OBJS) $(LDFLAGS) -o $(BIN_DIR)/$(CLIENT_NAME)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(LIBFT_LIB):
	@make debug -C $(LIBFT_DIR)

$(OBJS_DIR):
	mkdir -p $(OBJS_DIR)

$(OBJS_DIR)/server_%.o: $(SERVER_DIR)/%.c $(HEADER) | $(OBJS_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(OBJS_DIR)/client_%.o: $(CLIENT_DIR)/%.c $(HEADER) | $(OBJS_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

.PHONY: all clean fclean re

board = []
board.append(['Ф', 'Ф', 'Ф', 'Ф'])
board.append(['Ф', 'К', 'К', 'Ф'])
board.append(['К', 'Ф', 'К', 'Ф'])
board.append(['К', 'К', 'Ф', 'Ф'])

def visualize_quest(board):

    hor = "1234"
    s = "  "
    for i in range(4):
        s = s + " " + hor[i] + "  "
    print(s)
    
    line = " "
    for _ in range(17):
        line+="-"
    print(line)
    
    vert = "abcd"
    s = ""
    for i in range(4):
        s = s + vert[i] + "|"
        for j in range(4):
            s = s + " " + board[i][j] + " |"
        print(s)
        print(line)
        s = ""

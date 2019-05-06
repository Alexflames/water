from tkinter import *

class Quiz():
    def proceed_input(self, s):
        if len(s) == 0 or s[0] == '\n':
            self.input_empty_space()
        elif s[0] == '#':
            self.questions[self.q_i][1] = 'm'
            self.mode = 'a'
        elif s[0] == '~':
            self.questions[self.q_i][1] = 'f'
            self.mode = 'a'
        elif s[0] == '%':
            self.questions[self.q_i][1] = 's'
            self.mode = 'a'
        elif self.mode == 'q':
            self.input_question(s)
        elif self.mode == 'a':
            self.input_answer(s)
        
    def input_empty_space(self):
        if self.mode == 'a':
            self.mode = 'q'
            self.questions.append(['', 'm', []])
            self.q_i = self.q_i + 1


    def input_question(self, s):
        self.questions[self.q_i][0] = self.questions[self.q_i][0] + s + '\n'
        

    def input_answer(self, a):
        self.questions[self.q_i][2].append((a[2:], a[0]))


    def next_question(self, event):
        # check answer
        self.check_answer()
        print(self.points)

        # next question
        for item in self.question_widgets:
            item.destroy()
        self.question_widgets = []
        self.variables = []
        self.q_i = self.q_i + 1
        print(self.questions[self.q_i])
        self.label_quest_text.configure(text=self.questions[self.q_i][0])

        if self.questions[self.q_i][1] == 'm':
            for answer in self.questions[self.q_i][2]:
                check_value = IntVar()
                self.variables.append(check_value)
                check = Checkbutton(self.root,
                                    text=answer[0],
                                    var=self.variables[len(self.variables)-1])
                check.pack()
                self.question_widgets.append(check)
        

    def check_answer(self):
        if self.questions[self.q_i][1] == 'm':
            for i in range(len(self.variables)):
                if self.questions[self.q_i][2][i][1] == '+':
                    true_answer = 1
                else:
                    true_answer = 0
                if self.variables[i].get() != true_answer:
                    return
            self.points = self.points + 1
        
        
    def __init__(self, filename, main):
        f = open(filename)
        if not f:
            return

        # m = multiple, s = single, f = free
        # question text, mode, answers
        # (question, 'm'/'s'/'f' [(answer, -/+), (...)])
        self.questions = [['', 'm', []]]
        # q = question, a = answer
        self.mode = 'q'
        # current question index
        self.q_i = 0
        for s in f:
            self.proceed_input(s)

        # modify previous window

        # open Tkinter window
        root = Toplevel()
        root.title(u'Тестирование в процессе')
        root.geometry('600x600')
        self.label_quest_counter = Label(root, text="Вопрос №", font='arial 14')
        self.label_quest_counter.pack()
        self.label_quest_text = Label(root, text="0", font='arial 10')
        self.label_quest_text.pack(side='top')

        self.button_answer = Button(root, text='Ответить',
                             width = 10, height = 3, bg = '#bbbbbb',
                             fg = 'black', font = 'arial 14')
        self.button_answer.bind("<Button-1>", self.next_question)
        self.button_answer.pack(side='bottom')

        self.question_widgets = []

        self.points = 0

        self.q_i = -1
        self.next_question(0)
        main.button_start.configure(bg = '#edb636',
                                   text = 'Тестирование \n начато')
        
        print("Тест начат!")
        print(self.questions)
        self.root = root

#label
class Application():
    
    def __init__(self):
        # window settings
        root = Tk()
        root.title(u'Тестирование по Python')
        root.geometry('600x300')
        # greetings label
        label_info = Label(root, text="Вы можете пройти тест " +
                  "на знание языка программирования Python",
                  font='arial 14')
        label_info.pack()
        # button to start quiz                  
        self.button_start = Button(root, text='Начать тест',
                             width = 14, height = 7, bg = '#666666',
                             fg = 'black', font = 'arial 20')
        self.button_start.pack(side='top')
        self.button_start.bind("<Button-1>", self.create_quiz)
        self.quiz_filename = 't22questions.txt'
        # start main loop
        self.root = root
        root.mainloop()


    def create_quiz(self, event):
        self.button_start.bind("<Button-1>", self.return_function)
        q = Quiz(self.quiz_filename, self)
        

    def return_function():
        return

app = Application()
    

    

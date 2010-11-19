import urwid
#
#palette = [
#    ('banner', 'black', 'light gray', 'standout,underline'),
#    ('streak', 'black', 'dark red', 'standout'),
#    ('bg', 'black', 'dark blue')
#]
#
#txt = urwid.Text(('banner', 'Hello World'), align='left')
#map1 = urwid.AttrMap(txt, 'streak')
#
##fill = urwid.Filler(map1,'top')
##map2 = urwid.AttrMap(fill, 'bg')
#
#line = urwid.Divider(div_char='-')
##map3 = line.Filler(line, 'banner')
#
#content = urwid.SimpleListWalker([map1, line])
#listbox = urwid.ListBox(content)
#
#def show_or_exit(input):
#    if input in ('q', 'Q'):
#        raise urwid.ExitMainLoop()
#
#loop = urwid.MainLoop(listbox, palette, unhandled_input=show_or_exit)
#loop.run()

HORIZONTAL_BAR = u'\u2501'
VERTICAL_BAR = u'\u2502'

class GitGraphModel:
    def __init__(self):
        pass


class GitGraphView(urwid.WidgetWrap):
    palette = [
        ('body',         'black',      'light gray', 'standout'),
        ('header',       'white',      'dark red',   'bold'),
        ('screen edge',  'light blue', 'dark cyan'),
        ('main shadow',  'dark gray',  'black'),
        ('line',         'black',      'light gray', 'standout'),
        ('bg background','light gray', 'black'),
        ('bg 1',         'black',      'dark blue', 'standout'),
        ('bg 1 smooth',  'dark blue',  'black'),
        ('bg 2',         'black',      'dark cyan', 'standout'),
        ('bg 2 smooth',  'dark cyan',  'black'),
        ('button normal','light gray', 'dark blue', 'standout'),
        ('button select','white',      'dark green'),
        ('line',         'black',      'light gray', 'standout'),
        ('pg normal',    'white',      'black', 'standout'),
        ('pg complete',  'white',      'dark magenta'),
        ('pg smooth',     'dark magenta','black')
    ]

    def __init__(self, controller):
        self.controller = controller
        self.committers_colors = [ "#f80", "#0a0", "#0aa", "#80d"]
        self.committers_color_mapping = {}

        urwid.WidgetWrap.__init__(self, self.main_window())

        self.update_graph(1,2)

    
    def update_color_legend(self):
        committers = self.controller.get_committers()
        for committer in committers:
            if committer not in self.committers_color_mapping:
                self.committers_color_mapping[committer] = \
                        (committer,
                         'white',
                         self.committers_colors.pop())
        for key in self.committers_color_mapping:
            mapping = self.committers_color_mapping
            self.palette.append(committer_mapping)
                         

    def update_graph(self, min, max):
        """
            min and max are in the form (day, month, year)
        """
#        values = ( [6, 5, 2], [1, 3, 4], [2, 4, 4])
        self.update_color_legend()
        committers = self.controller.get_committers()
        values = []
        n_commits = self.controller.get_data()

        for n_commit in n_commits:
            level = 0
            this_column = []
            for committer in committers:
                level += n_commit[committer]
                this_column.insert(0, level)
            values.append(this_column)

        self.graph.set_data(values, 50)
        return True

    def main_window(self):
        self.update_color_legend()
        self.graph = urwid.BarGraph(self.controller.get_committers())
        self.graph_wrap = urwid.WidgetWrap(self.graph)
        vline = urwid.AttrWrap(urwid.SolidFill(VERTICAL_BAR), 'line')
        column1 = urwid.Pile([
                              ('fixed', 1, urwid.SolidFill(HORIZONTAL_BAR)),
                              ('weight', 1, self.graph),
                              ('fixed', 1, urwid.SolidFill(HORIZONTAL_BAR)) 
                            ])
        window = urwid.Columns([('weight',2, column1),
                                ('fixed', 1, vline)],
                                dividechars=1, focus_column=2)
        return window


class GitGraphController:
    def __init__(self):
        self.model = GitGraphModel()
        self.view = GitGraphView(self)
    def main(self):
        self.loop = urwid.MainLoop(self.view, self.view.palette)
        self.loop.run()
    def get_committers(self):
        return 'john', 'bob'
    def get_data(self):
        n_commits = [
            { "john": 11, "bob": 4 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 2 },
            { "john": 9, "bob": 3 },
            { "john": 1, "bob": 3 },
            { "john": 0, "bob": 16 },
            { "john": 19, "bob": 4 },
            { "john": 0, "bob": 16 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 3 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 2 },
            { "john": 9, "bob": 3 },
            { "john": 1, "bob": 3 },
            { "john": 0, "bob": 16 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 3 },
            { "john": 0, "bob": 16 },
            { "john": 19, "bob": 4 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 2 },
            { "john": 9, "bob": 3 },
            { "john": 1, "bob": 3 },
            { "john": 0, "bob": 16 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 2 },
            { "john": 9, "bob": 3 },
            { "john": 1, "bob": 3 },
            { "john": 19, "bob": 4 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 2 },
            { "john": 9, "bob": 3 },
            { "john": 1, "bob": 3 },
            { "john": 0, "bob": 16 },
            { "john": 5, "bob": 2 },
            { "john": 1, "bob": 2 },
            { "john": 9, "bob": 3 },
            { "john": 1, "bob": 3 },
            { "john": 0, "bob": 30 },
        ]
        return n_commits


def main():
    GitGraphController().main()

if __name__ == "__main__":
    main()

#!/usr/bin/python

# fontasia:
# List all fonts on the system and let the user group them into categories.

# Copyright 2010 by Akkana Peck. Share and enjoy under the GPLv2 or later!
# More info: http://shallowsky.com/software/fontasia

# Thanks to jan bodnar's ZetCode.com PyGTK/Pango tutorial.

import gtk
import pango
import os

class FontApp(gtk.Window):
    def __init__(self):
        super(FontApp, self).__init__()

        # No categories to start with
        self.category_fontlists = []
        self.category_buttons = []
        self.oldcolors = None
        self.highlightcolor = None
        self.DEFAULT_TEXT = "The quick brown fox jumped over the lazy dog"
        self.DEFAULT_FONT_SIZE = 18

        self.set_border_width(8)
        self.connect("destroy", self.save_and_quit)
        self.set_title("Fontasia: Categorize your fonts")

        main_hbox = gtk.HBox(spacing = 10)
        self.add(main_hbox)

        #
        # Left pane: the font list
        #
        sw = gtk.ScrolledWindow()
        sw.set_shadow_type(gtk.SHADOW_ETCHED_IN)
        sw.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)

        context = self.create_pango_context()
        self.all_families = context.list_families()
        self.store = gtk.ListStore(str)

        self.treeView = gtk.TreeView(self.store)
        self.treeView.set_rules_hint(True)
        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)

        selection = self.treeView.get_selection()
        selection.set_mode(gtk.SELECTION_MULTIPLE)

        self.treeView.connect("cursor-changed", self.render_font);

        sw.add(self.treeView)

        self.create_column(self.treeView)

        sw.set_size_request(250, 450)
        main_hbox.pack_start(sw, expand=True)

        #
        # Right pane: the controls
        #
        vbox = gtk.VBox(spacing=15)
        main_hbox.pack_start(vbox, expand=False)

        #
        # Font size
        #
        hbox = gtk.HBox(spacing=15)
        vbox.pack_start(hbox, expand=False)

        label = gtk.Label("Size:")
        hbox.pack_start(label, expand=False)

        adj = gtk.Adjustment(self.DEFAULT_FONT_SIZE, 1, 1000, 1)
        self.sizespin = gtk.SpinButton(adj)
        self.sizespin.set_numeric(True)
        self.sizespin.connect("value-changed", self.render_font);
        hbox.pack_start(self.sizespin, expand=False)

        #
        # View category menu
        #
        self.add_to_cats_menu_btn = gtk.OptionMenu()
        hbox.pack_start(self.add_to_cats_menu_btn, expand=False)

        # Quit button
        btn = gtk.Button("Quit")
        hbox.pack_end(btn, expand=False)
        btn.connect("clicked", self.save_and_quit);

        # Now we can get the default button background (I hope):
        widgcopy = btn.get_style().copy()
        self.oldcolors = widgcopy.bg
        self.highlightcolor = gtk.gdk.Color(0, 65535, 0)

        #
        # The preview
        #
        self.preview = gtk.Entry()
        self.preview.set_width_chars(45)
        self.preview.set_text(self.DEFAULT_TEXT)
        self.preview.set_size_request(550, 50)
        vbox.pack_start(self.preview, expand=False)

        # Categories header row
        hbox = gtk.HBox(spacing=8)
        vbox.pack_start(hbox, expand=False)
        label = gtk.Label("Categories")
        hbox.pack_start(label, expand=False)

        entry = gtk.Entry()
        entry.set_width_chars(20)
        hbox.pack_start(entry, expand=False)

        btn = gtk.Button("Add category")
        hbox.pack_start(btn, expand=False)
        btn.set_sensitive(False)
        btn.connect("clicked", self.add_category, entry);
        # The entry and button are tied together:
        entry.connect("changed", self.new_cat_entry_changed, btn);

        #btn = gtk.Button("Show all")
        #hbox.pack_end(btn, expand=False)
        #btn.connect("clicked", self.show_all_categories);

        #
        # The buttonbox: the list of category togglebuttons.
        #
        self.buttonbox = gtk.VBox(spacing=8)
        vbox.pack_start(self.buttonbox, expand=True)

        #
        # Just before showing, update everything:
        #
        self.read_category_file()
        self.update_font_list()

        # Done with UI, finish showing window
        #self.set_position(gtk.WIN_POS_CENTER)
        self.show_all()

    def save_and_quit(self, widget=None) :
        self.write_category_file()
        gtk.main_quit()

    def create_column(self, treeView):
        rendererText = gtk.CellRendererText()
        column = gtk.TreeViewColumn("Font name", rendererText, text=0)
        column.set_sort_column_id(0)
        treeView.set_search_column(0)
        treeView.append_column(column)

    def is_font_in_category(self, fontname, catname) :
        for i in range(0, len(self.category_buttons)) :
            if self.category_buttons[i].get_name() == catname :
                return ( fontname in self.category_fontlists[i] )
        return False

    #
    # If the font is already in the category, this will remove it:
    # it's a toggle
    #
    def toggle_font_in_category(self, fontname, catname) :
        for i in range(0, len(self.category_buttons)) :
            if self.category_buttons[i].get_name() == catname :
                if fontname in self.category_fontlists[i] :
                    self.category_fontlists[i].remove(fontname)
                else :
                    self.category_fontlists[i].append(fontname)
                return

    #
    # This is the callback from the font category togglebuttons.
    # It calls toggle_font_in_category.
    #
    def toggle_cur_font_in_cat(self, widget, catname) :
        selection = self.treeView.get_selection()
        model, item = selection.get_selected_rows()

        # Read all the selected fonts, not just the first one:
        for x in item :
            fontname = model[x[0]][0]
            #print "Adding", fontname, "to", catname
            self.toggle_font_in_category(fontname, catname)
            self.update_category_buttons(fontname)
        #self.catsmenu.set_active(0)
        self.treeView.grab_focus()

    # Update the View Categories option menu
    def update_cats_menu(self) :
        self.catsmenu = gtk.Menu()

        item = gtk.MenuItem("View category:")    # Dummy menu item first
        self.catsmenu.append(item)

        catname = "All fonts"
        item = gtk.MenuItem(catname)
        self.catsmenu.append(item)
        item.show()
        item.connect("activate", self.update_font_list_cb, catname)

        catname = "All in categories"
        item = gtk.MenuItem(catname)
        self.catsmenu.append(item)
        item.show()
        item.connect("activate", self.update_font_list_cb, catname)

        catname = "All uncategorized"
        item = gtk.MenuItem(catname)
        self.catsmenu.append(item)
        item.show()
        item.connect("activate", self.update_font_list_cb, catname)

        for btn in self.category_buttons :
            catname = btn.get_name()
            item = gtk.MenuItem(catname)
            self.catsmenu.append(item)
            #item.connect("activate", self.toggle_cur_font_in_cat, catname)
            item.connect("activate", self.update_font_list_cb, catname)
            item.show()
        self.add_to_cats_menu_btn.set_menu(self.catsmenu)

    def update_font_list_cb(self, widget, catname) :
        self.update_font_list(catname)

    def update_font_list(self, catname = "All fonts") :
        # figure out which buttons are toggled:
        # categories = []
        # for btn in self.category_buttons :
        #     if btn.get_active() :
        #         categories.append(btn.get_name())
        # show_all = (len(categories) == 0)

        special = (catname[0:3] == "All")
        if special :
            show_all = (catname == "All fonts")
            show_all_in_cats = (catname == "All in categories")
            show_all_not_in_cats = (catname == "All uncategorized")
        # if show_all or show_all_in_cats :
        #     for catbtn in self.category_buttons :
        #         catbtn.set_active(show_all_in_cats)

        # Create or clear the list store:
        self.store.clear()

        for ff in self.all_families:
            fname = ff.get_name()

            # Else not a special case. Just check for cat membership:
            if not special :
                if self.is_font_in_category(fname, catname) :
                    self.store.append([fname])
                continue

            if show_all :
                self.store.append([fname])
                continue

            if show_all_in_cats:
                for catbtn in self.category_buttons :
                    if self.is_font_in_category(fname, catbtn.get_name()) :
                        self.store.append([fname])
                        continue

            if show_all_not_in_cats :
                is_in_cat = False
                for catbtn in self.category_buttons :
                    if self.is_font_in_category(fname, catbtn.get_name()) :
                        is_in_cat = True
                        break
                if not is_in_cat :
                    self.store.append([fname])
                continue

        # Reset all the button colors, since nothing is selected now
        # (eventually might be nice to retain the old selection,
        # if it's still in the list):
        for btn in self.category_buttons :
            self.change_button_color(btn, False)

    #
    # Lines in the category file look like:
    # catname: font, font, font ...
    #
    def read_category_file(self) :
        self.cat_file_name = os.path.join(os.getenv("HOME"), ".config/fontasia/fontasia.cfg")
        try :
            catfp = open(self.cat_file_name, "r")
            while 1 :
                line = catfp.readline()
                if not line : break

                if line[0:4] == "set " :
                    varval = line[4:].strip().split("=")
                    if varval[0] == "string" :
                        self.preview.set_text(varval[1].strip())
                        continue
                    if varval[0] == "fontsize" :
                        self.sizespin.set_value(int(varval[1]))
                        continue
                    # Arguably should save any other values
                    # for writing back to the file even though
                    # we don't understand any others
                    else :
                        print "Skipping unknown setting", varval[0]
                        continue

                colon = line.find(":")
                if colon < 0 :
                    print "Didn't understand line", line,
                    continue
                catname = line[0:colon].strip()
                self.add_category(catname)
                line = line[colon+1:].strip()
                fonts = line.split(",")
                for font in fonts :
                    font = font.strip()
                    self.toggle_font_in_category(font, catname)
            catfp.close()
            self.update_cats_menu()
        except IOError :
            print "No config file yet -- Welcome to fontasia!"
            return

    def write_category_file(self) :
        catfp = open(self.cat_file_name, "w")
        txt = self.preview.get_text()
        if txt != self.DEFAULT_TEXT :
            try :
                print >>catfp, "set string=" + txt
            except :
                print "Problem saving the string -- reverting to default string"

        fontsize = self.sizespin.get_value()
        if fontsize != self.DEFAULT_FONT_SIZE :
            print >>catfp, "set fontsize=" + str(int(fontsize))

        for i in range(0, len(self.category_buttons)) :
            catname = self.category_buttons[i].get_name()
            print >>catfp, catname + ":", ', '.join(self.category_fontlists[i])
        catfp.close()
        print "Saved to", self.cat_file_name

    def new_cat_entry_changed(self, entry, btn) :
        btn.set_sensitive(entry.get_text_length() > 0)

    def category_exists(self, catname) :
        for btn in self.category_buttons :
            if btn.get_name() == catname :
                return True
        return False

    def add_category(self, newcat, entry=None) :
        if entry :
            newcat = entry.get_text()

        # Make sure we don't already have this category:
        if (self.category_exists(newcat)) :
            return

        btn = gtk.Button(newcat)  # was togglebutton
        btn.set_name(newcat)
        self.buttonbox.pack_start(btn, expand=False)
        btn.connect("clicked", self.toggle_cur_font_in_cat, newcat);
        btn.show()

        self.category_buttons.append(btn)
        self.category_fontlists.append([])
        self.update_cats_menu()

        # If any fonts are selected, most likely the user wants them
        # added to the new category.
        self.toggle_cur_font_in_cat(None, newcat)

        if (entry) :
            entry.set_text("")

    #
    # Callback for the main toggle buttons down the right half of the window.
    # Toggle whether XXX
    #
    #def category_toggle(self, widget, catname) :
    #    self.update_font_list()

    def change_button_color(self, btn, yesno) :
        if self.oldcolors == None :
            self.oldcolors = btn.get_modifier_style().bg
        if self.highlightcolor == None :
            self.highlightcolor = gtk.gdk.Color(0, 65535, 0)
        if yesno :
            btn.modify_bg(gtk.STATE_NORMAL, self.highlightcolor)
            btn.modify_bg(gtk.STATE_ACTIVE, self.highlightcolor)
            btn.modify_bg(gtk.STATE_PRELIGHT, self.highlightcolor)
            btn.modify_bg(gtk.STATE_SELECTED, self.highlightcolor)
        else :
            btn.modify_bg(gtk.STATE_NORMAL, self.oldcolors[gtk.STATE_NORMAL])
            btn.modify_bg(gtk.STATE_ACTIVE, self.oldcolors[gtk.STATE_ACTIVE])
            btn.modify_bg(gtk.STATE_PRELIGHT,
                          self.oldcolors[gtk.STATE_PRELIGHT])
            btn.modify_bg(gtk.STATE_SELECTED,
                          self.oldcolors[gtk.STATE_SELECTED])

    def update_category_buttons(self, fontname) :
        for i in range(0, len(self.category_buttons)) :
            if fontname in self.category_fontlists[i] :
                self.change_button_color(self.category_buttons[i], True)
                # Can't call set_active because that invokes the
                # callback which recursively calls this function.
                #self.category_buttons[i].set_active(True)
            else :
                self.change_button_color(self.category_buttons[i], False)
                #self.category_buttons[i].set_active(False)

    def render_font(self, widget) :
        selection = self.treeView.get_selection()
        model, item = selection.get_selected_rows()
        if not item :
            return

        size = self.sizespin.get_value()

        # Only render the first font.
        fontname = model[item[0][0]][0]

        # It's crazy appending the size as part of the font name string,
        # but I haven't found any more direct way to do it!
        fontdesc = pango.FontDescription(fontname + " " + str(size))
        self.preview.modify_font(fontdesc)

        self.update_category_buttons(fontname)

    def show_all_categories(self, widget) :
        for btn in self.category_buttons :
            btn.set_active(False)
        self.update_font_list()

FontApp()
gtk.main()

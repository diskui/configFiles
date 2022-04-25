# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os, subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.spawn("wofi")),
    Key([mod,"shift"], "space", lazy.spawn("kickoff")),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod,"shift"],"b",lazy.spawn("google-chrome-stable")),
    Key([mod],"p",lazy.spawn("flameshot gui")),
    Key([mod],"bracketleft",lazy.screen.prev_group()),
    Key([mod],"bracketright",lazy.screen.next_group()),

]

# groups = [Group(i) for i in "abcdefghij"]
groups = [Group("1", layout='columns'),
          Group("2", layout='columns'),
          Group("3", layout='columns'),
          Group("4", layout='columns'),
          Group("5", layout='columns'),
          Group("6", layout='columns'),
          Group("7", layout='columns'),
          Group("8", layout='columns'),
          Group("9", layout='columns'),
          Group("0", layout='columns')]


for k, group in zip(["1","2","3","4","5","6","7","8","9","0"], groups):
    keys.append(Key([mod], (k), lazy.group[group.name].toscreen()))
    keys.append(Key([mod, "shift"],(k), lazy.window.togroup(group.name)))




layouts = [
    layout.Columns(border_focus = '#ffffff', border_normal = '#696969', border_width=2, margin = 15),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(border_focus = '#ffffff',border_normal = '#696969',border_width=2,margin = 15),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=10,
)
extension_defaults = widget_defaults.copy()



#Colors for the bar
def init_colors():
    return [["#2e3440", "#2e3440"],
            ["#2e3440", "#2e3440"],
             ["#3b4252", "#3b4252"], 
             ["#434c5e", "#434c5e"], 
             ["#4c566a", "#4c566a"], 
             ["#d8dee9", "#d8dee9"],
             ["#e5e9f0", "#e5e9f0"],
             ["#eceff4", "#eceff4"],
             ["#8fbcbb", "#8fbcbb"],
             ["#88c0d0", "#88c0d0"],
             ["#81a1c1", "#81a1c1"],
             ["#5e81ac", "#5e81ac"],
             ["#bf616a", "#bf616a"],
             ["#d08770", "#d08770"],
             ["#ebcb8b", "#ebcb8b"],
             ["#a3be8c", "#a3be8c"],
             ["#b48ead", "#b48ead"]]

colors = init_colors()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    background='#00000020',
                    foreground='#00000020',
                    linewidth=0,
                    padding_x=10
                ),
                widget.GroupBox(
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 5,
                       borderwidth = 2,
                       active = '#ffffff',
                       inactive = '#777777',
                       highlight_method = "border",
                       highlight_color = "#A25EF8",
                       this_current_screen_border = "#a25ef8",
                       this_screen_border = "#a25ef8",
                       other_current_screen_border = "#a25ef8",
                       other_screen_border = "#a25ef8",
                       foreground = '#696969',
                       # background = "#00000060",
                       hide_unused = False
                    ),
                widget.WindowName(
                    padding = 10,
                    fontsize = 13,
                    empty_group_string = '  ',
                    format = ' {name}  ',
                    ),
                # widget.Backlight(
                #     change_command = 'xbacklight -set {0}'
                #     ),
                widget.PulseVolume(),
                widget.Memory(),
                widget.CPU(
                    format = 'CPU {load_percent}%',
                    ),
                widget.Battery(
                    format = 'Bat {percent:2.0%}',
                    ),
                widget.Wlan(
                    format = '{essid}',
                    ),
                widget.Clock(
                    format="%a, %b %d %I:%M %p",
                    margin_x = 10,
                    ),
                 widget.Sep(
                    background='#00000020',
                    foreground='#00000020',
                    linewidth=0,
                    padding_x=30,
                )
            ],
            24,
            background = "#00000060",
            opacity = 1.0,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = True
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # *layout.Floating.default_float_rules
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
     home = os.path.expanduser('~')
     subprocess.call([home + '/.config/qtile/autostart.sh'])






# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
# wmname = "LG3D"

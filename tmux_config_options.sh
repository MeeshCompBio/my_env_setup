# Start window numbering at 1
set-option -g base-index 1
set-window-option -g pane-base-index 1

setw -g mode-keys vi
#witch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
# Enable mouse mode (tmux 2.1 and above)
set -g mouse on
######################
### DESIGN CHANGES ###
######################

# panes
set -g pane-border-fg black
set -g pane-active-border-fg brightred

## Status bar design
# status line
set -g status-utf8 on
set -g status-justify left
set -g status-bg default
set -g status-fg colour12
set -g status-interval 2

#window mode
setw -g mode-bg colour6
setw -g mode-fg colour0

# window status

# loud or quiet?
set -g default-terminal "screen-256color"


{ catppuccin-tmux, ... }: {
  programs.tmux = {
    enable = true;

    mouse = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    prefix = "C-a";
    terminal = "screen-256color";

    extraConfig = ''
      # ================================
      #   Catppuccin plugin
      # --------------------------------

      set -g @catppuccin_flavour 'mocha'

      set -g @catppuccin_window_separator " "
      set -g @catppuccin_window_middle_separator " | "
      set -g @catppuccin_window_number_position "right"

      set -g @catppuccin_window_default_fill "none"
      set -g @catppuccin_window_default_text "#W"

      set -g @catppuccin_window_current_fill "all"
      set -g @catppuccin_window_current_text "#W"

      set -g @catppuccin_status_modules_right "directory session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "yes"
      set -g @catppuccin_status_background "default"

      set -g @catppuccin_directory_text "#{pane_current_path}"

      run ${catppuccin-tmux}/catppuccin.tmux

      # ================================

      set -as terminal-features ",alacritty*:RGB"
    '';
  };
}

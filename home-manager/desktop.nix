{ pkgs, inputs, system, ... }:
{
  imports = [
    ./common.nix
    ./work-desktop.nix
    ./software/git
    ./software/keeweb
    ./software/obsidian
    ./software/pycharm
    ./software/signal
    ./software/telegram
  ];
  home.packages = with pkgs; [
    appimage-run
    unstable.vscode
    unstable.youtube-dl
  ];
  programs.git.userEmail = "andreas@zweili.ch";

  # raw config files
  home.file.".config/qtile".source = ./desktop/configs/qtile;
  home.file.".config/terminator".source = ./desktop/configs/terminator;
  home.file.".config/mpv".source = ./desktop/configs/mpv;
  home.file.".config/Rapid Photo Downloader".source = ./desktop/configs/rapid_photo_downloader;
  home.file.".local/share/applications/steam.desktop".source = ./desktop/applications/steam.desktop;

  programs.bash = {
    enable = true;
    shellAliases = {
      management-server = "mosh --ssh='ssh -p 22' andreas@10.7.89.106 tmux a";
    };
  };

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  xsession.numlock.enable = true;
  services.network-manager-applet.enable = true;
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Source Code Pro 11";
        markup = "yes";
        plain_text = "no";
        format = "<b>%s</b>\n%b";
        sort = "no";
        indicate_hidden = "yes";
        alignment = "center";
        bounce_freq = 0;
        show_age_threshold = -1;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = "yes";
        hide_duplicates_count = "yes";
        geometry = "300x50-15+49";
        shrink = "no";
        transparency = 5;
        idle_threshold = 0;
        monitor = 0;
        follow = "none";
        sticky_history = "yes";
        history_length = 15;
        show_indicators = "no";
        line_height = 3;
        separator_height = 2;
        padding = 6;
        horizontal_padding = 6;
        separator_color = "frame";
        startup_notification = "false";
        browser = "firefox - new-tab";
        icon_position = "off";
        max_icon_size = 80;
        frame_width = 3;
        frame_color = "#8EC07C";
      };
      urgency_low = {
        frame_color = "#3B7C87";
        foreground = "#3B7C87";
        background = "#191311";
        #background = "#2B313C";
        timeout = 4;
      };
      urgency_normal = {
        frame_color = "#5B8234";
        foreground = "#5B8234";
        background = "#191311";
        #background = "#2B313C";
        timeout = 6;
      };
      urgency_critical = {
        frame_color = "#B7472A";
        foreground = "#B7472A";
        background = "#191311";
        #background = "#2B313C";
        timeout = 8;
      };
    };
  };
}

{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      nixos-update = "sudo nixos-rebuild switch --flake";
      home-update = "home-manager switch --flake";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = lib.concatStrings [
        "$os"
        "$username"
        "$directory"
        "$git_branch"
        "$git_status"
        "$rust"
        "$time"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];

      os = {
        disabled = false;
        style = "bg:red fg:black";
        format = "[](red)$os";
      };

      username = {
        show_always = true;
        style_user = "bg:red fg:black";
        style_root = "bg:red fg:black";
        format = "[$user]($style)";
      };

      directory = {
        style = "bg:bright-red fg:black";
        truncation_length = 3;
        truncation_symbol = ".../";
        format = "[](fg:red bg:bright-red)[$path]($style)";

        substitutions = {
          "Documents" = "󰈙";
          "Downloads" = "";
          "Music" = "󰝚";
          "Pictures" = "";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[](fg:bright-red bg:yellow)[$symbol $branch](fg:black bg:yellow)";
      };

      git_status = {
        style = "bg:yellow";
        format = "[[($all_status $ahead_behind)](fg:black bg:yellow)]($style)";
      };

      time = {
        disabled = false;
        style = "bg:bright-magenta";
        use_12hr = true;
        format = "[](fg:yellow bg:bright-magenta)[ $time ](fg:black bg:bright-magenta)";
      };

      rust = {
        symbol = "";
        style = "bg:base03";
        format = "[](fg:bright-magenta bg:base03)[$symbol($version)](fg:black bg:base03)";
      };

      cmd_duration = {
        disabled = false;
        format = "[](fg:bright-magenta bg:none)[  in $duration ](fg:bright-magenta)";
        show_milliseconds = true;
        show_notifications = true;
        min_time_to_notify = 45000;
      };

      line_break.disabled = true;
      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:blue)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:blue)";
        vimcmd_replace_one_symbol = "[❮](bold fg:bright-magenta)";
        vimcmd_replace_symbol = "[❮](bold fg:bright-magenta)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };

    };
  };
}

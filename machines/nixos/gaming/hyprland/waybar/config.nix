{ pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl
    pavucontrol
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  programs.waybar.settings = [
    (
      builtins.fromJSON ''
        {
            "layer": "top",
            "position": "top",
            "modules-left": ["cpu", "memory"],
            "modules-center": ["custom/music"],
            "modules-right": ["pulseaudio", "clock", "tray"],
            "tray": {
                "icon-size": 21,
                "spacing": 10
            },
            "cpu": {
                "interval": 1,
                "format": " {usage}%"
            },
            "memory": {
              "interval": 30,
            "format": " {percentage}% | {used:0.1f}G/{total:0.1f}G"  
            },
            "custom/music": {
                "format": "  {}",
                "escape": true,
                "interval": 5,
                "tooltip": false,
                "exec": "playerctl metadata --format='{{ title }}'",
                "on-click": "playerctl play-pause",
                "max-length": 50
            },
            "clock": {
                "timezone": "America/New_York",
                "format": " {:%m/%d/%Y |   %I:%M}"
            },
            "pulseaudio": {
                "format": "{icon} {volume}%",
                "format-muted": "",
                "format-icons": {
                    "default": ["", "", " "]
                },
                "on-click": "pavucontrol"
            }
        }
      ''
    )
  ];
}

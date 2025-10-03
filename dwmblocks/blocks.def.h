static const char *fonts[] = {
    "Jetbrains Nerd Font Mono:size=20",
    "Jetbrains Nerd Font Mono:size=13"
};

/*static const int interval = 200;*/

static const Block blocks[] = {
    /* Icon */             /* Command */                                                     /* Update Interval */   /* Update Signal */
    { " Volume: 󰕾 ",          "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100) \"%\"}'",          1,          0}, //Volume

    { " Memory:  ",                 "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",         30,                     0 }, // Memory

     {"Disk: ", "df -h / | awk 'NR==2 {print \" \"$5}'",                                                  60,                      0}, // Disk usage
    
   { "Battery: ",            "capacity=$(cat /sys/class/power_supply/BAT0/capacity); "
                     "if [ $capacity -ge 90 ]; then icon=''; "
                     "elif [ $capacity -ge 60 ]; then icon=''; "
                     "elif [ $capacity -ge 30 ]; then icon=''; "
                     "elif [ $capacity -ge 10 ]; then icon=''; "
                     "else icon=''; fi; "
                     "echo \"$icon $capacity%\"",                                                                1,                   0}, // Battery 

    { "Time and Date: 󰥔 ",                 "date '+%b %d (%a) %I:%M%p'",                                     5,                      0 }, // Clock

};

static char delim[] = " | ";
static unsigned int delimLen = 5;



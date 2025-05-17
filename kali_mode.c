#include <ncurses.h>
#include <stdlib.h>

void draw_menu(int highlight);
void print_usage_stats();

int main() {
    initscr();
    noecho();
    cbreak();
    curs_set(FALSE);
    keypad(stdscr, TRUE);

    int choice = 0;
    int highlight = 1;

    while(1) {
        clear();
        mvprintw(1, 2, "=== Kali Mode Switcher ===");
        print_usage_stats();
        draw_menu(highlight);
        int c = getch();

        switch(c) {
            case KEY_UP:
                if(highlight == 1)
                    highlight = 5;
                else
                    --highlight;
                break;
            case KEY_DOWN:
                if(highlight == 6)
                    highlight = 1;
                else
                    ++highlight;
                break;
            case 10: // Enter key
                choice = highlight;
                if(choice == 1) {
                    system("./kali_optimize.sh daily");
                } else if(choice == 2) {
                    system("./kali_optimize.sh pentest");
                } else if(choice == 3) {
                    system("./kali_optimize.sh forensics");
                } else if(choice == 4) {
                    system("./kali_optimize.sh wireless");
                } else if(choice == 5) {
                    system("./kali_optimize.sh stealth");
                }
	   	  else if(choice == 6){
		    endwin();
                 return 0;
		}

                break;
        }
    }

    endwin();
    return 0;
}

void draw_menu(int highlight) {
    char *choices[] = {
        "Daily Mode",
        "Pentest Mode",
        "Forensics Mode",
        "Wireless Audit Mode",
        "Stealth / Hardening Mode",
	"Exit"	
    };

    for(int i = 0; i < 6; ++i) {
        if(highlight == i+1)
            attron(A_REVERSE);
        mvprintw(6 + i * 2, 6, choices[i]);
        attroff(A_REVERSE);
    }
}

void print_usage_stats() {
    FILE *fp = popen("free -m | awk '/Mem:/ {printf \"RAM: %dMB / %dMB\", $3, $2}'", "r");
    char buffer[128];
    if (fp) {
        fgets(buffer, sizeof(buffer), fp);
        mvprintw(4, 40, buffer);
        pclose(fp);
    }

    fp = popen("top -bn1 | grep 'Cpu(s)' | awk '{print \"CPU: \" $2 \"% used\"}'", "r");
    if (fp) {
        fgets(buffer, sizeof(buffer), fp);
        mvprintw(5, 40, buffer);
        pclose(fp);
    }
}

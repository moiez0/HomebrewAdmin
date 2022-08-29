#include "stdafx.h"
#include <Windows.h>
#include <stdio.h>
#include <conio.h>

int main()
{
	int status;
    printf("Homebrew Admin\n");
	CreateMutex(NULL, TRUE, "ROBLOX_singletonMutex"); //bInitialOwner is TRUE, takes ownership and holds it until this process exits
	printf("Roblox multi-client ON.\n");
	printf("\n");
	status = system("server-win.exe");
	printf("Press any key to close\n");
	getch();
	return 0;
}

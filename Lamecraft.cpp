#include <math.h>

#include <psp2/kernel/threadmgr.h>
#include <psp2/kernel/processmgr.h>

#include <Aurora/Utils/Timer.h>
#include <Aurora/Utils/StateManager.h>

using namespace Aurora::Utils;

int main() 
{

    srand(time(NULL));

    //new state manager
    StateManager stateManager;
    stateManager.Init();

    //trun
	while ( stateManager.Running() )
	{

	}

    sceKernelExitProcess(0);

    return 0;
}
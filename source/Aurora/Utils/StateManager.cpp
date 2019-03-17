#include <stdio.h>
#include <string.h>

//gamestate/engine includes
#include <Aurora/Utils/StateManager.h>
#include <Aurora/Utils/GameState.h>

namespace Aurora 
{
    namespace Utils
    {
        void StateManager::Init()
        {
            m_running = true;
        }
    }
}
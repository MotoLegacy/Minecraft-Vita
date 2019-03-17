#include <Aurora/Utils/Timer.h>

namespace Aurora
{
	namespace Utils
	{

		Timer::Timer()
		{
			sceRtcGetCurrentTick( &timeLastAsk );
			tickResolution = sceRtcGetTickResolution();
		}

		Timer::~Timer()
		{

		}

		double Timer::GetDeltaTime( void )
		{
			sceRtcGetCurrentTick( &timeNow );
			double dt = ( (uint64_t) timeNow.tick - (uint64_t) timeLastAsk.tick ) / ((float) tickResolution );
			timeLastAsk = timeNow;

			return dt;
		}

	}
}